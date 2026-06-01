import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:chat_app/domain/models/enum/chat_type.dart';

class RoomEntity {
  final String? id;
  final String? roomName;
  final ChatType? type;
  final MessageEntity? lastMessage;
  final int? unreadCount;
  final List<String?> avatarGroup;
  final bool? isOnline;

  const RoomEntity({
    this.id,
    this.roomName,
    this.type,
    this.lastMessage,
    this.unreadCount,
    this.avatarGroup = const <String?>[],
    this.isOnline,
  });
}
