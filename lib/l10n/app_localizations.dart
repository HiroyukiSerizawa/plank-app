import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
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
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// App tagline shown above the timer ring
  ///
  /// In en, this message translates to:
  /// **'DO THE PLANK RIGHT NOW'**
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

  /// Main button to stop the timer without recording
  ///
  /// In en, this message translates to:
  /// **'ABORT'**
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
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
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
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
