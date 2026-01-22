class AssetConstants {
  AssetConstants._();

  // Base Paths (adjust according to your `pubspec.yaml`)
  static const String _imagesBasePath = 'assets/images';
  static const String _iconsBasePath = 'assets/icons';

  ///Icon Auth
  static const String iconGoogle = "$_iconsBasePath/icon_google.svg";
  static const String iconFacebook = "$_iconsBasePath/icon_facebook.svg";
  static const String iconApple = "$_iconsBasePath/icon_apple.svg";

  ///Icon
  static const String appIcon = "$_iconsBasePath/app_icon.svg";
  static const String backIcon = "$_iconsBasePath/icon_back.svg";
  static const String passwordVisibleIcon =
      '$_iconsBasePath/ic_password_visible.svg';
  static const String passwordInvisibleIcon =
      '$_iconsBasePath/ic_password_invisible.svg';
  static const String iconSearch = "$_iconsBasePath/icon_search.svg";


  ///Icon Bottom Navigation
  static const String iconMessage = "$_iconsBasePath/icon_message.svg";
  static const String iconCall = "$_iconsBasePath/icon_call.svg";
  static const String iconSetting = "$_iconsBasePath/icon_setting.svg";
  static const String iconContacts = "$_iconsBasePath/icon_contacts.svg";

  ///Image
  static const String logoAppText = "$_imagesBasePath/app_logo_text.png";
  static const String logoApp = "$_imagesBasePath/app_logo.png";
  static const String backgroundBlur = "$_imagesBasePath/background_blur.png";
  static const String userDefault = "$_imagesBasePath/user_default.png";

}