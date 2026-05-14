// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'SEGUNDOS';

  @override
  String get customChip => 'Otra';

  @override
  String get abort => 'CANCELAR';

  @override
  String get giveUp => 'RENDIRSE';

  @override
  String get retry => 'REINTENTAR';

  @override
  String get start => 'INICIAR';

  @override
  String get customDurationTitle => 'Duración personalizada';

  @override
  String get secInputSuffix => 'seg';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'Aceptar';

  @override
  String get historyTitle => 'HISTORIAL';

  @override
  String get noRecordsYet => 'AÚN SIN REGISTROS';

  @override
  String get secUnit => 'SEG';

  @override
  String get statsTitle => 'ESTADÍSTICAS';

  @override
  String get noDataYet => 'AÚN SIN DATOS';

  @override
  String get best => 'MEJOR';

  @override
  String get avg => 'MEDIA';

  @override
  String get dailyBestSection => 'MEJOR DIARIO  /  14 DÍAS';

  @override
  String get weeklyTotalSection => 'TOTAL SEMANAL  /  8 SEMANAS';

  @override
  String allRecordsSection(int count) {
    return 'TODOS LOS REGISTROS  /  $count SESIONES';
  }

  @override
  String get weekNow => 'AHORA';

  @override
  String get settingsTitle => 'AJUSTES';

  @override
  String get countdownVoiceLabel => 'Voz de cuenta atrás';

  @override
  String get countdownVoiceDescription =>
      'Guía de voz para el inicio y el final';

  @override
  String get vibrationLabel => 'Vibración';

  @override
  String get vibrationDescription => 'Vibra con cada cuenta';

  @override
  String streakDays(int count) {
    return 'Racha de $count días';
  }

  @override
  String shareRecordMessage(int seconds) {
    return '¡Aguanté la plancha $seconds segundos! 💪\n\nPlank Now — el temporizador de plancha sin adornos:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Sonido';

  @override
  String get soundDescription =>
      'Silencio general. Apagado: todos los sonidos en silencio.';
}
