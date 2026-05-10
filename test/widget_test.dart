import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plank_app/l10n/app_localizations.dart';
import 'package:plank_app/l10n/app_localizations_en.dart';
import 'package:plank_app/l10n/app_localizations_ja.dart';
import 'package:plank_app/l10n/app_localizations_ko.dart';
import 'package:plank_app/l10n/app_localizations_zh.dart';
import 'package:plank_app/main.dart';

void main() {
  testWidgets('PlankApp boots without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const PlankApp());
    // Pulse animation runs forever; pump a few frames instead of settling.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(PlankApp), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('AppLocalizations supports en, ja, ko, zh, zh_TW', () {
    final supportedLocales =
        AppLocalizations.supportedLocales.map((l) => l.toString()).toSet();
    expect(supportedLocales, containsAll(['en', 'ja', 'ko', 'zh', 'zh_TW']));
  });

  test('Each locale provides the START label', () {
    expect(AppLocalizationsEn().start, 'START');
    expect(AppLocalizationsJa().start, 'スタート');
    expect(AppLocalizationsKo().start, '시작');
    expect(AppLocalizationsZh().start, '開始');
  });

  test('Each locale provides the HISTORY title', () {
    expect(AppLocalizationsEn().historyTitle, 'HISTORY');
    expect(AppLocalizationsJa().historyTitle, '履歴');
    expect(AppLocalizationsKo().historyTitle, '기록');
    expect(AppLocalizationsZh().historyTitle, '紀錄');
  });

  test('Each locale provides the parameterized allRecordsSection', () {
    expect(AppLocalizationsEn().allRecordsSection(42),
        'ALL RECORDS  /  42 SESSIONS');
    expect(AppLocalizationsJa().allRecordsSection(42), '全記録  /  42セッション');
    expect(AppLocalizationsKo().allRecordsSection(42), '전체 기록  /  42회');
    expect(AppLocalizationsZh().allRecordsSection(42), '全部紀錄  /  42次');
  });

  test('AppLocalizations.delegate loads each locale', () async {
    for (final locale in [
      const Locale('en'),
      const Locale('ja'),
      const Locale('ko'),
      const Locale('zh'),
      const Locale('zh', 'TW'),
    ]) {
      expect(AppLocalizations.delegate.isSupported(locale), isTrue,
          reason: '$locale should be supported');
      final l10n = await AppLocalizations.delegate.load(locale);
      expect(l10n.start, isNotEmpty,
          reason: 'start label for $locale should not be empty');
    }
  });
}
