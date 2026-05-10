// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get slogan => 'चलो अभी प्लैंक करें';

  @override
  String get secRemaining => 'शेष सेकंड';

  @override
  String get secondsLabel => 'सेकंड';

  @override
  String get customChip => 'अपना';

  @override
  String get abort => 'रद्द';

  @override
  String get giveUp => 'हार';

  @override
  String get retry => 'फिर से';

  @override
  String get start => 'शुरू';

  @override
  String get customDurationTitle => 'कस्टम अवधि';

  @override
  String get secInputSuffix => 'सेकंड';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get ok => 'ठीक';

  @override
  String get historyTitle => 'इतिहास';

  @override
  String get noRecordsYet => 'अभी कोई रिकॉर्ड नहीं';

  @override
  String get secUnit => 'सेक';

  @override
  String get statsTitle => 'आंकड़े';

  @override
  String get noDataYet => 'अभी कोई डेटा नहीं';

  @override
  String get best => 'सर्वश्रेष्ठ';

  @override
  String get avg => 'औसत';

  @override
  String get dailyBestSection => 'दैनिक सर्वश्रेष्ठ  /  14 दिन';

  @override
  String get weeklyTotalSection => 'साप्ताहिक कुल  /  8 सप्ताह';

  @override
  String allRecordsSection(int count) {
    return 'सभी रिकॉर्ड  /  $count सत्र';
  }

  @override
  String get weekNow => 'अभी';
}
