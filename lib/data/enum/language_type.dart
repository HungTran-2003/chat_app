import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

enum Language {
  vietnam('vi', Locale('vi', 'VI')),
  english('en', Locale('en', 'US')),
  ;

  final String code;
  final Locale local;

  const Language(this.code, this.local);
}

extension LanguageExt on Language {
  bool get isVietNam => this == Language.vietnam;
  bool get isEnglish => this == Language.english;

  static Language? languageFromCode(String? code) {
    if (code == Language.english.code) {
      return Language.english;
    } else if (code == Language.vietnam.code) {
      return Language.vietnam;
    } else {
      return null;
    }
  }

  static Language languageFromName(String name) {
    return Language.values.firstWhere(
          (lang) => lang.name == name,
      orElse: () => Language.vietnam,
    );
  }

  int get id {
    switch (this) {
      case Language.vietnam:
        return 1;
      case Language.english:
        return 2;
    }
  }

  // String get name {
  //   switch (this) {
  //     case Language.vietnam:
  //       return S.current.lang_ja;
  //     case Language.english:
  //       return S.current.lang_en;
  //   }
  // }
}
