// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'DETIK';

  @override
  String get customChip => 'Khusus';

  @override
  String get abort => 'BATAL';

  @override
  String get giveUp => 'MENYERAH';

  @override
  String get retry => 'ULANGI';

  @override
  String get start => 'MULAI';

  @override
  String get customDurationTitle => 'Durasi Khusus';

  @override
  String get secInputSuffix => 'detik';

  @override
  String get cancel => 'Batal';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'RIWAYAT';

  @override
  String get noRecordsYet => 'BELUM ADA CATATAN';

  @override
  String get secUnit => 'DTK';

  @override
  String get statsTitle => 'STATISTIK';

  @override
  String get noDataYet => 'BELUM ADA DATA';

  @override
  String get best => 'TERBAIK';

  @override
  String get avg => 'RATA-RATA';

  @override
  String get dailyBestSection => 'TERBAIK HARIAN  /  14 HARI';

  @override
  String get weeklyTotalSection => 'TOTAL MINGGUAN  /  8 MINGGU';

  @override
  String allRecordsSection(int count) {
    return 'SEMUA CATATAN  /  $count SESI';
  }

  @override
  String get weekNow => 'KINI';
}
