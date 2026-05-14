// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => '秒';

  @override
  String get customChip => '自訂';

  @override
  String get abort => '取消';

  @override
  String get giveUp => '放棄';

  @override
  String get retry => '再來一次';

  @override
  String get start => '開始';

  @override
  String get customDurationTitle => '自訂秒數';

  @override
  String get secInputSuffix => '秒';

  @override
  String get cancel => '取消';

  @override
  String get ok => '確定';

  @override
  String get historyTitle => '紀錄';

  @override
  String get noRecordsYet => '尚無紀錄';

  @override
  String get secUnit => '秒';

  @override
  String get statsTitle => '統計';

  @override
  String get noDataYet => '尚無資料';

  @override
  String get best => '最佳';

  @override
  String get avg => '平均';

  @override
  String get dailyBestSection => '每日最佳  /  近14日';

  @override
  String get weeklyTotalSection => '每週合計  /  近8週';

  @override
  String allRecordsSection(int count) {
    return '全部紀錄  /  $count次';
  }

  @override
  String get weekNow => '本週';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => '秒';

  @override
  String get customChip => '自訂';

  @override
  String get abort => '取消';

  @override
  String get giveUp => '放棄';

  @override
  String get retry => '再來一次';

  @override
  String get start => '開始';

  @override
  String get customDurationTitle => '自訂秒數';

  @override
  String get secInputSuffix => '秒';

  @override
  String get cancel => '取消';

  @override
  String get ok => '確定';

  @override
  String get historyTitle => '紀錄';

  @override
  String get noRecordsYet => '尚無紀錄';

  @override
  String get secUnit => '秒';

  @override
  String get statsTitle => '統計';

  @override
  String get noDataYet => '尚無資料';

  @override
  String get best => '最佳';

  @override
  String get avg => '平均';

  @override
  String get dailyBestSection => '每日最佳  /  近14日';

  @override
  String get weeklyTotalSection => '每週合計  /  近8週';

  @override
  String allRecordsSection(int count) {
    return '全部紀錄  /  $count次';
  }

  @override
  String get weekNow => '本週';
}
