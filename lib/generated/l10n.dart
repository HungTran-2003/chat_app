// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Chatbox`
  String get common_app_title {
    return Intl.message(
      'Chatbox',
      name: 'common_app_title',
      desc: '',
      args: [],
    );
  }

  /// `Connect friends <easily & quickly>`
  String get onboard_app_title {
    return Intl.message(
      'Connect friends <easily & quickly>',
      name: 'onboard_app_title',
      desc: '',
      args: [],
    );
  }

  /// `Our chat app is the perfect way to stay connected with friends and family.`
  String get onboard_description {
    return Intl.message(
      'Our chat app is the perfect way to stay connected with friends and family.',
      name: 'onboard_description',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with email`
  String get common_sign_up_with_email {
    return Intl.message(
      'Sign up with email',
      name: 'common_sign_up_with_email',
      desc: '',
      args: [],
    );
  }

  /// `Existing account? <Log in>`
  String get common_have_account_login {
    return Intl.message(
      'Existing account? <Log in>',
      name: 'common_have_account_login',
      desc: '',
      args: [],
    );
  }

  /// `<Log in> to Chatbox`
  String get auth_login_title {
    return Intl.message(
      '<Log in> to Chatbox',
      name: 'auth_login_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Sign in using your social account or email to continue us`
  String get auth_login_description {
    return Intl.message(
      'Welcome back! Sign in using your social account or email to continue us',
      name: 'auth_login_description',
      desc: '',
      args: [],
    );
  }

  /// `Your email`
  String get common_your_email {
    return Intl.message(
      'Your email',
      name: 'common_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get common_password {
    return Intl.message(
      'Password',
      name: 'common_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get common_forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'common_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get common_sign_in {
    return Intl.message('Login', name: 'common_sign_in', desc: '', args: []);
  }

  /// `Sign up`
  String get common_sign_up {
    return Intl.message('Sign up', name: 'common_sign_up', desc: '', args: []);
  }

  /// `Sign up with <Email>`
  String get auth_register_title {
    return Intl.message(
      'Sign up with <Email>',
      name: 'auth_register_title',
      desc: '',
      args: [],
    );
  }

  /// `Get chatting with friends and family today by signing up for our chat app!`
  String get auth_register_description {
    return Intl.message(
      'Get chatting with friends and family today by signing up for our chat app!',
      name: 'auth_register_description',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get common_label_name {
    return Intl.message(
      'Your name',
      name: 'common_label_name',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get common_confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'common_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get common_create_account {
    return Intl.message(
      'Create an account',
      name: 'common_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Network connection error. Please check your internet connection.`
  String get common_message_network_error {
    return Intl.message(
      'Network connection error. Please check your internet connection.',
      name: 'common_message_network_error',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to perform this action.`
  String get common_message_permission_denied {
    return Intl.message(
      'You do not have permission to perform this action.',
      name: 'common_message_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `You need to sign in to continue.`
  String get common_message_unauthenticated {
    return Intl.message(
      'You need to sign in to continue.',
      name: 'common_message_unauthenticated',
      desc: '',
      args: [],
    );
  }

  /// `The submitted data is invalid.`
  String get common_message_invalid_data {
    return Intl.message(
      'The submitted data is invalid.',
      name: 'common_message_invalid_data',
      desc: '',
      args: [],
    );
  }

  /// `The requested data could not be found.`
  String get common_message_data_not_found {
    return Intl.message(
      'The requested data could not be found.',
      name: 'common_message_data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `The data already exists.`
  String get common_message_data_already_exists {
    return Intl.message(
      'The data already exists.',
      name: 'common_message_data_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `The system is temporarily overloaded. Please try again later.`
  String get common_message_quota_exceeded {
    return Intl.message(
      'The system is temporarily overloaded. Please try again later.',
      name: 'common_message_quota_exceeded',
      desc: '',
      args: [],
    );
  }

  /// `The request took too long to process. Please try again.`
  String get common_message_timeout {
    return Intl.message(
      'The request took too long to process. Please try again.',
      name: 'common_message_timeout',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again later.`
  String get common_message_unexpected_error {
    return Intl.message(
      'An unexpected error occurred. Please try again later.',
      name: 'common_message_unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `User not found.`
  String get common_message_user_not_found {
    return Intl.message(
      'User not found.',
      name: 'common_message_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password.`
  String get common_message_wrong_password {
    return Intl.message(
      'Incorrect password.',
      name: 'common_message_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `The email address is invalid.`
  String get common_message_invalid_email {
    return Intl.message(
      'The email address is invalid.',
      name: 'common_message_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled.`
  String get common_message_user_disabled {
    return Intl.message(
      'This account has been disabled.',
      name: 'common_message_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get nav_message {
    return Intl.message('Message', name: 'nav_message', desc: '', args: []);
  }

  /// `Call`
  String get nav_call {
    return Intl.message('Call', name: 'nav_call', desc: '', args: []);
  }

  /// `Contact`
  String get nav_contact {
    return Intl.message('Contact', name: 'nav_contact', desc: '', args: []);
  }

  /// `Setting`
  String get nav_setting {
    return Intl.message('Setting', name: 'nav_setting', desc: '', args: []);
  }

  /// `Home`
  String get common_home {
    return Intl.message('Home', name: 'common_home', desc: '', args: []);
  }

  /// `My status`
  String get common_my_status {
    return Intl.message(
      'My status',
      name: 'common_my_status',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get common_time_just_now {
    return Intl.message(
      'Just now',
      name: 'common_time_just_now',
      desc: '',
      args: [],
    );
  }

  /// `{count}m ago`
  String common_time_minutes_ago(Object count) {
    return Intl.message(
      '${count}m ago',
      name: 'common_time_minutes_ago',
      desc: '',
      args: [count],
    );
  }

  /// `Monday`
  String get common_time_weekday_monday {
    return Intl.message(
      'Monday',
      name: 'common_time_weekday_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get common_time_weekday_tuesday {
    return Intl.message(
      'Tuesday',
      name: 'common_time_weekday_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get common_time_weekday_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'common_time_weekday_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get common_time_weekday_thursday {
    return Intl.message(
      'Thursday',
      name: 'common_time_weekday_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get common_time_weekday_friday {
    return Intl.message(
      'Friday',
      name: 'common_time_weekday_friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get common_time_weekday_saturday {
    return Intl.message(
      'Saturday',
      name: 'common_time_weekday_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get common_time_weekday_sunday {
    return Intl.message(
      'Sunday',
      name: 'common_time_weekday_sunday',
      desc: '',
      args: [],
    );
  }

  /// `Time parsing error`
  String get common_message_time_parsing_error {
    return Intl.message(
      'Time parsing error',
      name: 'common_message_time_parsing_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
