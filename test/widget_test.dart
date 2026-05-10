import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plank_app/l10n/app_localizations.dart';
import 'package:plank_app/l10n/app_localizations_de.dart';
import 'package:plank_app/l10n/app_localizations_en.dart';
import 'package:plank_app/l10n/app_localizations_es.dart';
import 'package:plank_app/l10n/app_localizations_fr.dart';
import 'package:plank_app/l10n/app_localizations_hi.dart';
import 'package:plank_app/l10n/app_localizations_id.dart';
import 'package:plank_app/l10n/app_localizations_ja.dart';
import 'package:plank_app/l10n/app_localizations_ko.dart';
import 'package:plank_app/l10n/app_localizations_pt.dart';
import 'package:plank_app/l10n/app_localizations_vi.dart';
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

  test('AppLocalizations supports all Tier S + Tier A locales', () {
    final supportedLocales =
        AppLocalizations.supportedLocales.map((l) => l.toString()).toSet();
    expect(
        supportedLocales,
        containsAll([
          // Tier S (initial release)
          'en', 'ja', 'ko', 'zh', 'zh_TW',
          // Tier A (global expansion)
          'es', 'pt', 'pt_BR', 'de', 'fr', 'id', 'hi', 'vi',
        ]));
  });

  test('Each locale provides a non-empty START label', () {
    expect(AppLocalizationsEn().start, 'START');
    expect(AppLocalizationsJa().start, 'スタート');
    expect(AppLocalizationsKo().start, '시작');
    expect(AppLocalizationsZh().start, '開始');
    expect(AppLocalizationsEs().start, 'INICIAR');
    expect(AppLocalizationsPt().start, 'INICIAR');
    expect(AppLocalizationsDe().start, 'STARTEN');
    expect(AppLocalizationsFr().start, 'DÉMARRER');
    expect(AppLocalizationsId().start, 'MULAI');
    expect(AppLocalizationsHi().start, 'शुरू');
    expect(AppLocalizationsVi().start, 'BẮT ĐẦU');
  });

  test('Each locale provides a non-empty HISTORY title', () {
    expect(AppLocalizationsEn().historyTitle, 'HISTORY');
    expect(AppLocalizationsJa().historyTitle, '履歴');
    expect(AppLocalizationsKo().historyTitle, '기록');
    expect(AppLocalizationsZh().historyTitle, '紀錄');
    expect(AppLocalizationsEs().historyTitle, 'HISTORIAL');
    expect(AppLocalizationsPt().historyTitle, 'HISTÓRICO');
    expect(AppLocalizationsDe().historyTitle, 'VERLAUF');
    expect(AppLocalizationsFr().historyTitle, 'HISTORIQUE');
    expect(AppLocalizationsId().historyTitle, 'RIWAYAT');
    expect(AppLocalizationsHi().historyTitle, 'इतिहास');
    expect(AppLocalizationsVi().historyTitle, 'LỊCH SỬ');
  });

  test('Parameterized allRecordsSection interpolates count in each locale', () {
    final variants = {
      AppLocalizationsEn(): 'ALL RECORDS  /  42 SESSIONS',
      AppLocalizationsJa(): '全記録  /  42セッション',
      AppLocalizationsKo(): '전체 기록  /  42회',
      AppLocalizationsZh(): '全部紀錄  /  42次',
      AppLocalizationsEs(): 'TODOS LOS REGISTROS  /  42 SESIONES',
      AppLocalizationsPt(): 'TODOS OS REGISTROS  /  42 SESSÕES',
      AppLocalizationsDe(): 'ALLE EINTRÄGE  /  42 EINHEITEN',
      AppLocalizationsFr(): 'TOUS LES RECORDS  /  42 SÉANCES',
      AppLocalizationsId(): 'SEMUA CATATAN  /  42 SESI',
      AppLocalizationsHi(): 'सभी रिकॉर्ड  /  42 सत्र',
      AppLocalizationsVi(): 'TẤT CẢ KỶ LỤC  /  42 LẦN',
    };
    variants.forEach((l10n, expected) {
      expect(l10n.allRecordsSection(42), expected);
    });
  });

  test('AppLocalizations.delegate loads each supported locale', () async {
    for (final locale in AppLocalizations.supportedLocales) {
      expect(AppLocalizations.delegate.isSupported(locale), isTrue,
          reason: '$locale should be supported');
      final l10n = await AppLocalizations.delegate.load(locale);
      expect(l10n.start, isNotEmpty,
          reason: 'start label for $locale should not be empty');
      expect(l10n.historyTitle, isNotEmpty,
          reason: 'historyTitle for $locale should not be empty');
      expect(l10n.allRecordsSection(1), contains('1'),
          reason: 'allRecordsSection for $locale should interpolate count');
    }
  });
}
