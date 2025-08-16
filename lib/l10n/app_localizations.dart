import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @onboarding_p1_title.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get onboarding_p1_title;

  /// No description provided for @onboarding_p1_description.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.'**
  String get onboarding_p1_description;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get dark_theme;

  /// No description provided for @onboarding_p1_lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get onboarding_p1_lets_start;

  /// No description provided for @onboarding_p2_title.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get onboarding_p2_title;

  /// No description provided for @onboarding_p2_description.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get onboarding_p2_description;

  /// No description provided for @onboarding_p3_title.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get onboarding_p3_title;

  /// No description provided for @onboarding_p3_description.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we\'ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get onboarding_p3_description;

  /// No description provided for @onboarding_p4_title.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get onboarding_p4_title;

  /// No description provided for @onboarding_p4_description.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get onboarding_p4_description;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get login_forget_password;

  /// No description provided for @forget_password_screen_forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password_screen_forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account ?'**
  String get login_dont_have_account;

  /// No description provided for @login_create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get login_create_account;

  /// No description provided for @login_login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_login_with_google;

  /// No description provided for @register_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get register_name;

  /// No description provided for @register_already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account ?'**
  String get register_already_have_account;

  /// No description provided for @forgot_password_reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgot_password_reset_password;

  /// No description provided for @forgot_password_reset_email_title.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we will send you a link to reset your password.'**
  String get forgot_password_reset_email_title;

  /// No description provided for @home_screen_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get home_screen_welcome_back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @love.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get love;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @love_tab_search_for_event.
  ///
  /// In en, this message translates to:
  /// **'Search For Event'**
  String get love_tab_search_for_event;

  /// No description provided for @profile_tab_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_tab_logout;

  /// No description provided for @create_event_screen_create_event.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get create_event_screen_create_event;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @event_description.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get event_description;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get event_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get event_time;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @choose_event_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get choose_event_location;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get add_event;

  /// No description provided for @event_details.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get event_details;

  /// No description provided for @edit_event_screen_edit_event.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get edit_event_screen_edit_event;

  /// No description provided for @edit_event_screen_update_event.
  ///
  /// In en, this message translates to:
  /// **'Update Event'**
  String get edit_event_screen_update_event;

  /// No description provided for @field_can_not_be_empty.
  ///
  /// In en, this message translates to:
  /// **'Field Can Not Be Empty'**
  String get field_can_not_be_empty;

  /// No description provided for @email_can_not_be_less_than_5_characters.
  ///
  /// In en, this message translates to:
  /// **'Email Can Not be Less Than 5 Characters'**
  String get email_can_not_be_less_than_5_characters;

  /// No description provided for @password_can_not_be_less_than_6_characters.
  ///
  /// In en, this message translates to:
  /// **'Password Can Not be Less Than 6 Characters'**
  String get password_can_not_be_less_than_6_characters;

  /// No description provided for @name_can_not_be_less_than_3_characters.
  ///
  /// In en, this message translates to:
  /// **'Name Can Not be Less Than 3 Characters'**
  String get name_can_not_be_less_than_3_characters;

  /// No description provided for @category_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get category_all;

  /// No description provided for @category_sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get category_sport;

  /// No description provided for @category_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get category_birthday;

  /// No description provided for @category_meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get category_meeting;

  /// No description provided for @category_gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get category_gaming;

  /// No description provided for @category_eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get category_eating;

  /// No description provided for @category_holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get category_holiday;

  /// No description provided for @category_exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get category_exhibition;

  /// No description provided for @category_workshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get category_workshop;

  /// No description provided for @category_bookclub.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get category_bookclub;

  /// No description provided for @created_by.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get created_by;

  /// No description provided for @title_can_not_be_less_than_3_characters.
  ///
  /// In en, this message translates to:
  /// **'Title Must Be Atleast 3 characters'**
  String get title_can_not_be_less_than_3_characters;

  /// No description provided for @description_can_not_be_less_than_10_characters.
  ///
  /// In en, this message translates to:
  /// **'Description Must Be Atleast 10 characters'**
  String get description_can_not_be_less_than_10_characters;

  /// No description provided for @please_provide_a_date.
  ///
  /// In en, this message translates to:
  /// **'Please Provide A Date !'**
  String get please_provide_a_date;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get choose_date;

  /// No description provided for @please_provide_a_time.
  ///
  /// In en, this message translates to:
  /// **'Please Provide A Time !'**
  String get please_provide_a_time;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get choose_time;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout?'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
