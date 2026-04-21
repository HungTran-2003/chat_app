import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class LoginNavigator extends BaseNavigator{
  LoginNavigator({required super.context});

  void openSignUpPage(){
    pushNamed(AppRouter.registerRouteName);
  }

  Future<void> goToHomePage()async {
    goNamed(AppRouter.chatRouterName);
  }
}