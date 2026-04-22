import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/record.dart';

class DatabaseService {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'plank.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) => db.execute(
        'CREATE TABLE records(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, seconds INTEGER)',
      ),
    );
  }

  static Future<void> insert(Record record) async {
    final db = await database;
    await db.insert('records', record.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Record>> getAll() async {
    final db = await database;
    final maps = await db.query('records', orderBy: 'date DESC');
    return maps.map(Record.fromMap).toList();
  }

  static Future<void> delete(int id) async {
    final db = await database;
    await db.delete('records', where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>> getStats() async {
    final records = await getAll();
    if (records.isEmpty) {
      return {'best': 0, 'avg': 0.0, 'daily': <DateTime, int>{}, 'weekly': <int, int>{}};
    }
    final best = records.map((r) => r.seconds).reduce((a, b) => a > b ? a : b);
    final avg = records.map((r) => r.seconds).reduce((a, b) => a + b) / records.length;

    // 日別最高記録（直近14日）
    final now = DateTime.now();
    final Map<DateTime, int> daily = {};
    for (var i = 13; i >= 0; i--) {
      final d = DateTime(now.year, now.month, now.day - i);
      daily[d] = 0;
    }
    for (final r in records) {
      final d = DateTime(r.date.year, r.date.month, r.date.day);
      if (daily.containsKey(d) && r.seconds > (daily[d] ?? 0)) {
        daily[d] = r.seconds;
      }
    }

    // 週別合計（直近8週）
    final Map<int, int> weekly = {};
    for (var i = 7; i >= 0; i--) {
      weekly[i] = 0;
    }
    for (final r in records) {
      final weeksAgo = now.difference(r.date).inDays ~/ 7;
      if (weeksAgo <= 7) {
        weekly[weeksAgo] = (weekly[weeksAgo] ?? 0) + r.seconds;
      }
    }

    // 全記録（古い順）
    final allAsc = records.reversed.toList();

    return {'best': best, 'avg': avg, 'daily': daily, 'weekly': weekly, 'all': allAsc};
  }
}
