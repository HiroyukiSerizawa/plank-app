// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get slogan => 'TẬP PLANK NGAY BÂY GIỜ';

  @override
  String get secRemaining => 'GIÂY CÒN LẠI';

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
}
