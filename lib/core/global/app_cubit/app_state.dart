part of 'app_cubit.dart';

class AppState extends Equatable {
  final Language currentLanguage;
  final MainNavItem? currentMainPage;
  final MainNavItem previousMainPage;

  const AppState({
    this.currentLanguage = AppConfigs.defaultLanguage,
    this.currentMainPage = MainNavItem.message,
    this.previousMainPage = MainNavItem.message,
  });

  @override
  List<Object?> get props => [
    currentLanguage,
    currentMainPage,
    previousMainPage,
  ];

  AppState copyWith({
    Language? currentLanguage,
    MainNavItem? currentMainPage,
    MainNavItem? previousMainPage,
  }) {
    return AppState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentMainPage: currentMainPage ?? this.currentMainPage,
      previousMainPage: previousMainPage ?? this.previousMainPage,
    );
  }
}
