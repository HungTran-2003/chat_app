import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class RegisterNavigator extends BaseNavigator {
  RegisterNavigator({required super.context});

  void goHome(){
    goNamed(AppRouter.chatRouterName);
  }
}