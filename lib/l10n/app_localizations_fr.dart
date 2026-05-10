// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get slogan => 'FAIS LA PLANCHE MAINTENANT';

  @override
  String get secRemaining => 'SEC RESTANTES';

  @override
  String get secondsLabel => 'SECONDES';

  @override
  String get customChip => 'Autre';

  @override
  String get abort => 'ANNULER';

  @override
  String get giveUp => 'ABANDONNER';

  @override
  String get retry => 'RÉESSAYER';

  @override
  String get start => 'DÉMARRER';

  @override
  String get customDurationTitle => 'Durée personnalisée';

  @override
  String get secInputSuffix => 'sec';

  @override
  String get cancel => 'Annuler';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'HISTORIQUE';

  @override
  String get noRecordsYet => 'AUCUN ENREGISTREMENT';

  @override
  String get secUnit => 'SEC';

  @override
  String get statsTitle => 'STATS';

  @override
  String get noDataYet => 'AUCUNE DONNÉE';

  @override
  String get best => 'MEILLEUR';

  @override
  String get avg => 'MOY.';

  @override
  String get dailyBestSection => 'MEILLEUR JOURNALIER  /  14 JOURS';

  @override
  String get weeklyTotalSection => 'TOTAL HEBDO  /  8 SEMAINES';

  @override
  String allRecordsSection(int count) {
    return 'TOUS LES RECORDS  /  $count SÉANCES';
  }

  @override
  String get weekNow => 'MAINT.';
}
