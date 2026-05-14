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

  @override
  String get settingsTitle => 'PENGATURAN';

  @override
  String get countdownVoiceLabel => 'Suara Hitung Mundur';

  @override
  String get countdownVoiceDescription => 'Panduan suara untuk awal dan akhir';

  @override
  String get vibrationLabel => 'Getaran';

  @override
  String get vibrationDescription => 'Bergetar pada setiap hitungan';

  @override
  String streakDays(int count) {
    return '$count hari berturut';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'Berhasil plank selama $seconds detik! 💪\n\nPlank Now — timer plank tanpa ribet:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Suara';

  @override
  String get soundDescription =>
      'Bisukan master. Saat mati, semua suara dibisukan.';

  @override
  String get viewHistory => 'LIHAT RIWAYAT';

  @override
  String get confirmCancel => 'Batalkan?';

  @override
  String get confirmGiveUp => 'Menyerah?';

  @override
  String get yes => 'YA';

  @override
  String get no => 'TIDAK';
}
