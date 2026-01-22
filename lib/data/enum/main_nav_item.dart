import 'package:chat_app/core/constants/asset_constants.dart';
import 'package:chat_app/generated/l10n.dart';

enum MainNavItem {
  message,
  call,
  contact,
  setting,
}

extension MainNavItemExtension on MainNavItem {
  bool get isMessage => this == MainNavItem.message;
  bool get isCall => this == MainNavItem.call;
  bool get isContact => this == MainNavItem.contact;
  bool get isSetting => this == MainNavItem.setting;

  String get title {
    switch (this) {
      case MainNavItem.message:
        return S.current.nav_message;
        case MainNavItem.call:
        return S.current.nav_call;
        case MainNavItem.contact:
        return S.current.nav_contact;
      case MainNavItem.setting:
        return S.current.nav_setting;
    }
  }

  String get icon {
    switch (this) {
      case MainNavItem.message:
        return AssetConstants.iconMessage;
        case MainNavItem.call:
        return AssetConstants.iconCall;
        case MainNavItem.contact:
        return AssetConstants.iconContacts;
      case MainNavItem.setting:
        return AssetConstants.iconSetting;
    }
  }
}
