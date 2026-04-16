part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Language currentLanguage;

  ///Data
  final UserEntity? currentUser;

  const AppSettingState({
    this.currentLanguage = AppConfigs.defaultLanguage,
    this.currentUser,
  });

  @override
  List<Object?> get props => [
        currentLanguage,
        currentUser,
      ];

  AppSettingState copyWith({
    Language? currentLanguage,
    UserEntity? currentUser,
  }) {
    return AppSettingState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
