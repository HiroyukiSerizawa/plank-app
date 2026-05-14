// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'SECONDS';

  @override
  String get customChip => 'Custom';

  @override
  String get abort => 'CANCEL';

  @override
  String get giveUp => 'GIVE UP';

  @override
  String get retry => 'RETRY';

  @override
  String get start => 'START';

  @override
  String get customDurationTitle => 'Custom Duration';

  @override
  String get secInputSuffix => 'sec';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'HISTORY';

  @override
  String get noRecordsYet => 'NO RECORDS YET';

  @override
  String get secUnit => 'SEC';

  @override
  String get statsTitle => 'STATS';

  @override
  String get noDataYet => 'NO DATA YET';

  @override
  String get best => 'BEST';

  @override
  String get avg => 'AVG';

  @override
  String get dailyBestSection => 'DAILY BEST  /  14 DAYS';

  @override
  String get weeklyTotalSection => 'WEEKLY TOTAL  /  8 WEEKS';

  @override
  String allRecordsSection(int count) {
    return 'ALL RECORDS  /  $count SESSIONS';
  }

  @override
  String get weekNow => 'NOW';

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get countdownVoiceLabel => 'Countdown Voice';

  @override
  String get countdownVoiceDescription =>
      'Voice guide for the start and finish';

  @override
  String get vibrationLabel => 'Vibration';

  @override
  String get vibrationDescription => 'Pulse with each countdown beat';

  @override
  String streakDays(int count) {
    return '$count-day streak';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'I held a plank for $seconds seconds! 💪\n\nPlank Now — the no-frills plank timer:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Sound';

  @override
  String get soundDescription =>
      'Master mute. When off, all sounds are silenced.';

  @override
  String get viewHistory => 'VIEW HISTORY';

  @override
  String get confirmCancel => 'Cancel?';

  @override
  String get confirmGiveUp => 'Give up?';

  @override
  String get yes => 'YES';

  @override
  String get no => 'NO';
}
