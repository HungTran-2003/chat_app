part of 'main_cubit.dart';

class MainState extends Equatable {
  final MainNavItem currentMainPage;

  const MainState({
    this.currentMainPage = MainNavItem.message,
  });

  @override
  List<Object?> get props => [currentMainPage];

  MainState copyWith({
    MainNavItem? currentMainPage,
  }) {
    return MainState(
      currentMainPage: currentMainPage ?? this.currentMainPage,
    );
  }
}
