// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get slogan => '지금 플랭크하자';

  @override
  String get secRemaining => '남은 초';

  @override
  String get secondsLabel => '초';

  @override
  String get customChip => '사용자 지정';

  @override
  String get abort => '취소';

  @override
  String get giveUp => '포기';

  @override
  String get retry => '다시';

  @override
  String get start => '시작';

  @override
  String get customDurationTitle => '사용자 지정 시간';

  @override
  String get secInputSuffix => '초';

  @override
  String get cancel => '취소';

  @override
  String get ok => '확인';

  @override
  String get historyTitle => '기록';

  @override
  String get noRecordsYet => '아직 기록이 없습니다';

  @override
  String get secUnit => '초';

  @override
  String get statsTitle => '통계';

  @override
  String get noDataYet => '아직 데이터가 없습니다';

  @override
  String get best => '최고';

  @override
  String get avg => '평균';

  @override
  String get dailyBestSection => '일별 최고  /  최근 14일';

  @override
  String get weeklyTotalSection => '주별 합계  /  최근 8주';

  @override
  String allRecordsSection(int count) {
    return '전체 기록  /  $count회';
  }

  @override
  String get weekNow => '이번주';
}
