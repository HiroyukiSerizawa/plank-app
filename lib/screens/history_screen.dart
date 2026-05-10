import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/record.dart';
import '../services/database_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Record>> _records;

  @override
  void initState() {
    super.initState();
    _records = DatabaseService.getAll();
  }

  String _fmt(DateTime d) =>
      '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF030614),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color(0xFF00D4FF).withValues(alpha: 0.5), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Color(0xFF00D4FF), size: 16),
          ),
        ),
        title: _NeonTitle(l10n.historyTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 背景グロー
          Positioned(
            top: -60,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00D4FF).withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          FutureBuilder<List<Record>>(
            future: _records,
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF00D4FF),
                    strokeWidth: 1.5,
                  ),
                );
              }
              final records = snap.data!;
              if (records.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history,
                          size: 48,
                          color: const Color(0xFF00D4FF).withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noRecordsYet,
                        style: TextStyle(
                          color: const Color(0xFF00D4FF).withValues(alpha: 0.5),
                          fontSize: 13,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: records.length,
                itemBuilder: (_, i) {
                  final r = records[i];
                  final isTop = i == 0;
                  return _RecordTile(
                    record: r,
                    dateLabel: _fmt(r.date),
                    highlight: isTop,
                    rank: i + 1,
                    secLabel: l10n.secUnit,
                    onDelete: () async {
                      await DatabaseService.delete(r.id!);
                      setState(() {
                        _records = DatabaseService.getAll();
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NeonTitle extends StatelessWidget {
  final String text;
  const _NeonTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 6,
        color: Color(0xFF00D4FF),
        shadows: [
          Shadow(color: Color(0xFF00D4FF), blurRadius: 10),
          Shadow(color: Color(0xFF00D4FF), blurRadius: 20),
        ],
      ),
    );
  }
}

class _RecordTile extends StatelessWidget {
  final Record record;
  final String dateLabel;
  final bool highlight;
  final int rank;
  final String secLabel;
  final VoidCallback onDelete;

  const _RecordTile({
    required this.record,
    required this.dateLabel,
    required this.highlight,
    required this.rank,
    required this.secLabel,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final accent =
        highlight ? const Color(0xFFFFB347) : const Color(0xFF00D4FF);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 1),
        borderRadius: BorderRadius.circular(6),
        color: accent.withValues(alpha: 0.04),
        boxShadow: highlight
            ? [BoxShadow(color: accent.withValues(alpha: 0.1), blurRadius: 12)]
            : null,
      ),
      child: Row(
        children: [
          // ランク番号
          SizedBox(
            width: 28,
            child: Text(
              '#$rank',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1,
                color: accent.withValues(alpha: 0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 日時
          Expanded(
            child: Text(
              dateLabel,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.7),
                letterSpacing: 0.5,
              ),
            ),
          ),
          // 秒数
          Text(
            '${record.seconds}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w200,
              color: accent,
              shadows: [Shadow(color: accent.withValues(alpha: 0.7), blurRadius: 8)],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            secLabel,
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              color: accent.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFFFF4466).withValues(alpha: 0.4),
                    width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.delete_outline,
                  size: 16, color: Color(0xFFFF4466)),
            ),
          ),
        ],
      ),
    );
  }
}
