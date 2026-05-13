// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get slogan => 'PLANKEN WIR JETZT';

  @override
  String get secRemaining => 'SEK ÜBRIG';

  @override
  String get secondsLabel => 'SEKUNDEN';

  @override
  String get customChip => 'Eigene';

  @override
  String get abort => 'ABBRECHEN';

  @override
  String get giveUp => 'AUFGEBEN';

  @override
  String get retry => 'NOCHMAL';

  @override
  String get start => 'STARTEN';

  @override
  String get customDurationTitle => 'Eigene Dauer';

  @override
  String get secInputSuffix => 'Sek';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'VERLAUF';

  @override
  String get noRecordsYet => 'NOCH KEINE EINTRÄGE';

  @override
  String get secUnit => 'SEK';

  @override
  String get statsTitle => 'STATISTIK';

  @override
  String get noDataYet => 'NOCH KEINE DATEN';

  @override
  String get best => 'BESTE';

  @override
  String get avg => 'Ø';

  @override
  String get dailyBestSection => 'TAGESBESTE  /  14 TAGE';

  @override
  String get weeklyTotalSection => 'WOCHENSUMME  /  8 WOCHEN';

  @override
  String allRecordsSection(int count) {
    return 'ALLE EINTRÄGE  /  $count EINHEITEN';
  }

  @override
  String get weekNow => 'JETZT';

  @override
  String get settingsTitle => 'EINSTELLUNGEN';

  @override
  String get countdownVoiceLabel => 'Countdown-Stimme';

  @override
  String get countdownVoiceDescription => 'Sprachführung für Start und Ende';
}
