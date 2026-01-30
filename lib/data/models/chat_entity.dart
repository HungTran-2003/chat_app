import 'package:chat_app/data/enum/chat_type.dart';
import 'package:chat_app/data/models/message_entity.dart';
import 'package:chat_app/data/models/user_entity.dart';

class ChatEntity {
  final String? id;
  final String? chatName;
  final ChatType? type;
  final List<UserEntity>? users;
  final MessageEntity? lastMessage;
  final int? unreadCount;
  final String? avatarGroup;
  final bool? isOnline;

  const ChatEntity({
    this.id,
    this.chatName,
    this.type,
    this.users,
    this.lastMessage,
    this.unreadCount,
    this.avatarGroup,
    this.isOnline
  });

  static List<ChatEntity> mockData() {
    return [
      ChatEntity(
        id: "1",
        chatName: "Chat test 1jhdawekjkaskdqeasdedqeadedqweasdqeidadqwdasdqj2wlkuhasd",
        type: ChatType.private,
        users: [
          UserEntity(
            uid: "2",
            userName: "User 2",
            avatarPath: "https://i.pravatar.cc/150?u=bob",
          ),
        ],
        lastMessage: MessageEntity(
          messageId: "1",
          senderId: "1",
          context: "Hello",
          createdAt: "2026-01-30T07:00:00Z",
        ),
        unreadCount: 2,
        isOnline: true,
      ),

      ChatEntity(
        id: "2",
        chatName: "Group test 1",
        type: ChatType.group,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "2",
            userName: "User 2",
            avatarPath: "https://i.pravatar.cc/150?u=bob",
          ),
          UserEntity(
            uid: "4",
            userName: "User 4",
            avatarPath: "https://i.pravatar.cc/150?u=david",
          ),
        ],
        lastMessage: MessageEntity(
          messageId: "2",
          senderId: "1",
          context: "Hello group",
          createdAt: "2026-01-30T06:00:00Z",
        ),
        unreadCount: 0,
        isOnline: false,
      ),

      ChatEntity(
        id: "3",
        chatName: "Group test 2",
        type: ChatType.group,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "4",
            userName: "User 4",
            avatarPath: "https://i.pravatar.cc/150?u=david",
          ),
        ],
        lastMessage: MessageEntity(
          messageId: "2",
          senderId: "1",
          context: "Hello group",
          createdAt: "2026-01-30T06:00:00Z",
        ),
        unreadCount: 0,
        isOnline: false,
      ),
    ];
  }
}
