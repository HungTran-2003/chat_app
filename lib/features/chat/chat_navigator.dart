import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/navigation/app_router.dart';

class ChatNavigator extends BaseNavigator {
  ChatNavigator({required super.context});

  void openChatMessage(){
    pushNamed(AppRouter.chatMessageRouterName);
  }
}