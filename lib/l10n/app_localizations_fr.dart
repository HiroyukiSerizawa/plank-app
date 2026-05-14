// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get slogan => 'FAISONS LA PLANCHE MAINTENANT';

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

  @override
  String get settingsTitle => 'PARAMÈTRES';

  @override
  String get countdownVoiceLabel => 'Voix du compte à rebours';

  @override
  String get countdownVoiceDescription =>
      'Guidage vocal pour le début et la fin';

  @override
  String get vibrationLabel => 'Vibration';

  @override
  String get vibrationDescription => 'Vibre à chaque temps';

  @override
  String streakDays(int count) {
    return 'Série de $count jours';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'J\'ai tenu la planche pendant $seconds secondes ! 💪\n\nPlank Now — le minuteur de planche sans fioritures :\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Son';

  @override
  String get soundDescription =>
      'Coupure générale. Désactivé : tous les sons coupés.';
}
