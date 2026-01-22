part of 'app_cubit.dart';

class AppState extends Equatable {
  final Language currentLanguage;
  final MainNavItem? currentMainPage;
  final MainNavItem previousMainPage;

  ///Data
  final UserEntity? currentUser;

  const AppState({
    this.currentLanguage = AppConfigs.defaultLanguage,
    this.currentMainPage = MainNavItem.message,
    this.previousMainPage = MainNavItem.message,
    this.currentUser,
  });

  @override
  List<Object?> get props => [
    currentLanguage,
    currentMainPage,
    previousMainPage,
    currentUser,
  ];

  AppState copyWith({
    Language? currentLanguage,
    MainNavItem? currentMainPage,
    MainNavItem? previousMainPage,
    UserEntity? currentUser,
  }) {
    return AppState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentMainPage: currentMainPage ?? this.currentMainPage,
      previousMainPage: previousMainPage ?? this.previousMainPage,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
