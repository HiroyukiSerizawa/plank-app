// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => '秒';

  @override
  String get customChip => 'カスタム';

  @override
  String get abort => 'キャンセル';

  @override
  String get giveUp => 'ギブアップ';

  @override
  String get retry => 'もう一度';

  @override
  String get start => 'スタート';

  @override
  String get customDurationTitle => 'カスタム秒数';

  @override
  String get secInputSuffix => '秒';

  @override
  String get cancel => 'キャンセル';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => '履歴';

  @override
  String get noRecordsYet => 'まだ記録がありません';

  @override
  String get secUnit => '秒';

  @override
  String get statsTitle => '統計';

  @override
  String get noDataYet => 'まだデータがありません';

  @override
  String get best => 'ベスト';

  @override
  String get avg => '平均';

  @override
  String get dailyBestSection => '日別ベスト  /  直近14日';

  @override
  String get weeklyTotalSection => '週別合計  /  直近8週';

  @override
  String allRecordsSection(int count) {
    return '全記録  /  $countセッション';
  }

  @override
  String get weekNow => '今週';

  @override
  String get settingsTitle => '設定';

  @override
  String get countdownVoiceLabel => 'カウントダウン音声';

  @override
  String get countdownVoiceDescription => 'プランクの開始と終了を音声でガイド';

  @override
  String get vibrationLabel => 'バイブレーション';

  @override
  String get vibrationDescription => 'カウントダウンに合わせて振動';

  @override
  String streakDays(int count) {
    return '$count日連続';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'プランクを $seconds秒キープできた！💪\n\nPlank Now — シンプル一択のプランクタイマー：\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'サウンド';

  @override
  String get soundDescription => 'マスターミュート。OFFですべての音を消音';

  @override
  String get viewHistory => '履歴を見る';

  @override
  String get confirmCancel => 'キャンセルしますか？';

  @override
  String get confirmGiveUp => 'ギブアップしますか？';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';
}
