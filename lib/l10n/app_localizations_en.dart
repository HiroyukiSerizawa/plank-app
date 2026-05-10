// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get slogan => 'DO THE PLANK RIGHT NOW';

  @override
  String get secRemaining => 'SEC REMAINING';

  @override
  String get secondsLabel => 'SECONDS';

  @override
  String get customChip => 'Custom';

  @override
  String get abort => 'ABORT';

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
}
