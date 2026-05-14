// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get slogan => 'LET\'S PLANK NOW';

  @override
  String get secondsLabel => 'GIÂY';

  @override
  String get customChip => 'Tùy chỉnh';

  @override
  String get abort => 'HỦY';

  @override
  String get giveUp => 'BỎ CUỘC';

  @override
  String get retry => 'THỬ LẠI';

  @override
  String get start => 'BẮT ĐẦU';

  @override
  String get customDurationTitle => 'Thời lượng tùy chỉnh';

  @override
  String get secInputSuffix => 'giây';

  @override
  String get cancel => 'Hủy';

  @override
  String get ok => 'OK';

  @override
  String get historyTitle => 'LỊCH SỬ';

  @override
  String get noRecordsYet => 'CHƯA CÓ KỶ LỤC';

  @override
  String get secUnit => 'GIÂY';

  @override
  String get statsTitle => 'THỐNG KÊ';

  @override
  String get noDataYet => 'CHƯA CÓ DỮ LIỆU';

  @override
  String get best => 'TỐT NHẤT';

  @override
  String get avg => 'TB';

  @override
  String get dailyBestSection => 'TỐT NHẤT MỖI NGÀY  /  14 NGÀY';

  @override
  String get weeklyTotalSection => 'TỔNG HÀNG TUẦN  /  8 TUẦN';

  @override
  String allRecordsSection(int count) {
    return 'TẤT CẢ KỶ LỤC  /  $count LẦN';
  }

  @override
  String get weekNow => 'TUẦN NÀY';

  @override
  String get settingsTitle => 'CÀI ĐẶT';

  @override
  String get countdownVoiceLabel => 'Giọng đếm ngược';

  @override
  String get countdownVoiceDescription =>
      'Hướng dẫn bằng giọng cho lúc bắt đầu và kết thúc';

  @override
  String get vibrationLabel => 'Rung';

  @override
  String get vibrationDescription => 'Rung theo mỗi nhịp đếm';

  @override
  String streakDays(int count) {
    return 'Chuỗi $count ngày';
  }

  @override
  String shareRecordMessage(int seconds) {
    return 'Tôi đã giữ plank $seconds giây! 💪\n\nPlank Now — đồng hồ plank đơn giản:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app';
  }

  @override
  String get soundLabel => 'Âm thanh';

  @override
  String get soundDescription => 'Tắt tổng. Khi tắt, mọi âm thanh đều im lặng.';

  @override
  String get viewHistory => 'XEM LỊCH SỬ';

  @override
  String get confirmCancel => 'Huỷ?';

  @override
  String get confirmGiveUp => 'Bỏ cuộc?';

  @override
  String get yes => 'CÓ';

  @override
  String get no => 'KHÔNG';
}
