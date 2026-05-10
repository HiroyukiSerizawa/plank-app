// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get slogan => 'PLANCHA AHORA MISMO';

  @override
  String get secRemaining => 'SEG RESTANTES';

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
}
