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
