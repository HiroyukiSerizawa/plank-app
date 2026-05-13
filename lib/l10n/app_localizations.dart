import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// App tagline shown above the timer ring (inclusive 'let's' form)
  ///
  /// In en, this message translates to:
  /// **'LET\'S PLANK NOW'**
  String get slogan;

  /// Label under the timer countdown while running
  ///
  /// In en, this message translates to:
  /// **'SEC REMAINING'**
  String get secRemaining;

  /// Label under the timer ring when idle
  ///
  /// In en, this message translates to:
  /// **'SECONDS'**
  String get secondsLabel;

  /// Preset chip that opens the custom-duration dialog
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customChip;

  /// Main button to stop the timer without recording (cancel-style label)
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get abort;

  /// Main button to stop early but still record the elapsed seconds
  ///
  /// In en, this message translates to:
  /// **'GIVE UP'**
  String get giveUp;

  /// Main button to start a new attempt after finishing
  ///
  /// In en, this message translates to:
  /// **'RETRY'**
  String get retry;

  /// Main button to begin the timer
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get start;

  /// Title of the custom duration dialog
  ///
  /// In en, this message translates to:
  /// **'Custom Duration'**
  String get customDurationTitle;

  /// Suffix shown next to the seconds input field
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get secInputSuffix;

  /// Generic cancel action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Generic confirmation action
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// AppBar title of the history screen
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get historyTitle;

  /// Empty state shown when there are no records
  ///
  /// In en, this message translates to:
  /// **'NO RECORDS YET'**
  String get noRecordsYet;

  /// Compact 'seconds' suffix shown next to record durations
  ///
  /// In en, this message translates to:
  /// **'SEC'**
  String get secUnit;

  /// AppBar title of the stats screen
  ///
  /// In en, this message translates to:
  /// **'STATS'**
  String get statsTitle;

  /// Empty state shown when stats have no data
  ///
  /// In en, this message translates to:
  /// **'NO DATA YET'**
  String get noDataYet;

  /// Stat card label for personal best seconds
  ///
  /// In en, this message translates to:
  /// **'BEST'**
  String get best;

  /// Stat card label for average seconds
  ///
  /// In en, this message translates to:
  /// **'AVG'**
  String get avg;

  /// Section title above the daily best line chart
  ///
  /// In en, this message translates to:
  /// **'DAILY BEST  /  14 DAYS'**
  String get dailyBestSection;

  /// Section title above the weekly total bar chart
  ///
  /// In en, this message translates to:
  /// **'WEEKLY TOTAL  /  8 WEEKS'**
  String get weeklyTotalSection;

  /// Section title above the all-records chart with session count
  ///
  /// In en, this message translates to:
  /// **'ALL RECORDS  /  {count} SESSIONS'**
  String allRecordsSection(int count);

  /// Bar chart x-axis label for the current week
  ///
  /// In en, this message translates to:
  /// **'NOW'**
  String get weekNow;

  /// AppBar title of the settings screen
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// Settings toggle label for SFX/voice countdown
  ///
  /// In en, this message translates to:
  /// **'Countdown Voice'**
  String get countdownVoiceLabel;

  /// Settings toggle description for SFX/voice countdown
  ///
  /// In en, this message translates to:
  /// **'Voice guide for the start and finish'**
  String get countdownVoiceDescription;

  /// Settings toggle label for haptic feedback on countdown
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibrationLabel;

  /// Settings toggle description for haptic feedback
  ///
  /// In en, this message translates to:
  /// **'Pulse with each countdown beat'**
  String get vibrationDescription;

  /// Streak badge shown on the home screen when the user has consecutive recording days
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String streakDays(int count);

  /// Message used when sharing a plank record to other apps. Includes a {seconds} placeholder and a link to the Play Store listing.
  ///
  /// In en, this message translates to:
  /// **'I held a plank for {seconds} seconds! 💪\n\nPlank Now — the no-frills plank timer:\nhttps://play.google.com/store/apps/details?id=com.thunderstruck.plank_app'**
  String shareRecordMessage(int seconds);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'ja',
    'ko',
    'pt',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
