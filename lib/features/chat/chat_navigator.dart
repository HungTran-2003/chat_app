import 'package:chat_app/core/base/base_navigator.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/navigation/app_router.dart';

class ChatNavigator extends BaseNavigator {
  ChatNavigator({required super.context});

  void openChatMessage({required RoomEntity room}) {
    pushNamed(AppRouter.chatMessageRouterName, extra: room);
  }
}