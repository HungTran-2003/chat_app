import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class OnboardingNavigator extends BaseNavigator{
  OnboardingNavigator({required super.context});

  void goToRegisterPage(){
    goNamed(AppRouter.registerRouteName);
  }

  void goToLoginPage(){
    goNamed(AppRouter.loginRouteName);
  }
}