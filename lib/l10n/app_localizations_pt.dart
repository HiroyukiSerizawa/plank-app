// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'SEGUNDOS';

  @override
  String get customChip => 'Outra';

  @override
  String get abort => 'CANCELAR';

  @override
  String get giveUp => 'DESISTIR';

  @override
  String get retry => 'TENTAR DE NOVO';

  @override
  String get start => 'INICIAR';

  @override
  String get customDurationTitle => 'Duração personalizada';

  @override
  String get secInputSuffix => 'seg';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'HISTÓRICO';

  @override
  String get noRecordsYet => 'AINDA SEM REGISTROS';

  @override
  String get secUnit => 'SEG';

  @override
  String get statsTitle => 'ESTATÍSTICAS';

  @override
  String get noDataYet => 'AINDA SEM DADOS';

  @override
  String get best => 'MELHOR';

  @override
  String get avg => 'MÉDIA';

  @override
  String get dailyBestSection => 'MELHOR DIÁRIO  /  14 DIAS';

  @override
  String get weeklyTotalSection => 'TOTAL SEMANAL  /  8 SEMANAS';

  @override
  String allRecordsSection(int count) {
    return 'TODOS OS REGISTROS  /  $count SESSÕES';
  }

  @override
  String get weekNow => 'AGORA';

  @override
  String get settingsTitle => 'DEFINIÇÕES';

  @override
  String get countdownVoiceLabel => 'Voz da contagem decrescente';

  @override
  String get countdownVoiceDescription => 'Guia de voz para o início e o fim';

  @override
  String get vibrationLabel => 'Vibração';

  @override
  String get vibrationDescription => 'Pulsa a cada contagem';

  @override
  String streakDays(int count) {
    return 'Sequência de $count dias';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'Aguentei a prancha durante $seconds segundos! 💪\n\nPlank Now — temporizador de prancha sem firulas:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Som';

  @override
  String get soundDescription =>
      'Silenciar geral. Quando desligado, todos os sons silenciados.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'SEGUNDOS';

  @override
  String get customChip => 'Outra';

  @override
  String get abort => 'CANCELAR';

  @override
  String get giveUp => 'DESISTIR';

  @override
  String get retry => 'TENTAR DE NOVO';

  @override
  String get start => 'INICIAR';

  @override
  String get customDurationTitle => 'Duração personalizada';

  @override
  String get secInputSuffix => 'seg';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'HISTÓRICO';

  @override
  String get noRecordsYet => 'AINDA SEM REGISTROS';

  @override
  String get secUnit => 'SEG';

  @override
  String get statsTitle => 'ESTATÍSTICAS';

  @override
  String get noDataYet => 'AINDA SEM DADOS';

  @override
  String get best => 'MELHOR';

  @override
  String get avg => 'MÉDIA';

  @override
  String get dailyBestSection => 'MELHOR DIÁRIO  /  14 DIAS';

  @override
  String get weeklyTotalSection => 'TOTAL SEMANAL  /  8 SEMANAS';

  @override
  String allRecordsSection(int count) {
    return 'TODOS OS REGISTROS  /  $count SESSÕES';
  }

  @override
  String get weekNow => 'AGORA';

  @override
  String get settingsTitle => 'CONFIGURAÇÕES';

  @override
  String get countdownVoiceLabel => 'Voz da contagem regressiva';

  @override
  String get countdownVoiceDescription => 'Guia de voz para o início e o fim';

  @override
  String get vibrationLabel => 'Vibração';

  @override
  String get vibrationDescription => 'Pulsa a cada contagem';

  @override
  String streakDays(int count) {
    return 'Sequência de $count dias';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'Aguentei a prancha por $seconds segundos! 💪\n\nPlank Now — o cronômetro de prancha direto ao ponto:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Som';

  @override
  String get soundDescription =>
      'Mudo geral. Quando desligado, todos os sons silenciados.';
}
