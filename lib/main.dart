import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'l10n/app_localizations.dart';
import 'screens/timer_screen.dart';
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

class PlankApp extends StatelessWidget {
  const PlankApp({super.key});

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
