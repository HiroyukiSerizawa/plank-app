import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'l10n/app_localizations.dart';
import 'screens/timer_screen.dart';
import 'services/ad_service.dart';
import 'services/haptic_service.dart';
import 'services/sound_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  if (!kIsWeb) await MobileAds.instance.initialize();
  await SoundService.instance.init();
  await HapticService.instance.init();
  runApp(const PlankApp());
}

class PlankApp extends StatefulWidget {
  const PlankApp({super.key});

  @override
  State<PlankApp> createState() => _PlankAppState();
}

class _PlankAppState extends State<PlankApp> with WidgetsBindingObserver {
  /// 「アプリが少なくとも一度 background に落ちたか」のフラグ。
  /// コールドスタート直後の lifecycle 遷移で App Open 広告が暴発しないようにする。
  bool _wasBackgrounded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // App Open 広告を起動時に先読み（次回バックグラウンド復帰時に出すため）。
    AdService.loadAppOpenAd();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _wasBackgrounded = true;
    } else if (state == AppLifecycleState.resumed && _wasBackgrounded) {
      _wasBackgrounded = false;
      AdService.showAppOpenAdIfAvailable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plank Now',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF030614),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00D4FF),
          secondary: Color(0xFFFFB347),
          surface: Color(0xFF0A1628),
        ),
        useMaterial3: true,
      ),
      home: const TimerScreen(),
    );
  }
}
