import 'package:chat_app/data/enum/chat_type.dart';
import 'package:chat_app/data/models/message_entity.dart';
import 'package:chat_app/data/models/user_entity.dart';

class ChatEntity {
  final String? id;
  final String? title;
  final ChatType? type;
  final List<UserEntity>? users;
  final MessageEntity? lastMessage;

  const ChatEntity({
    this.id,
    this.title,
    this.type,
    this.users,
    this.lastMessage,
  });

  static List<ChatEntity> mockData() {
    return [
      ChatEntity(
        id: "1",
        title: "Chat test 1",
        type: ChatType.private,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
          ),
          UserEntity(
            uid: "2",
            userName: "User 2",
          ),
        ],
        lastMessage: MessageEntity(
          messageId: "1",
          senderId: "1",
          context: "Hello",
        )
      ),
    ];
  }
}
