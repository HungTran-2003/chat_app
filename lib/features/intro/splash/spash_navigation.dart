import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator({required super.context});

  void goToOnboarding(){
    goNamed(AppRouter.onboardingRouteName);
  }
}