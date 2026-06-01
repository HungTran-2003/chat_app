import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/enum/chat_type.dart';

class RoomResponse {
  final String? id;
  final bool? isGroup;
  final String? createdAt;
  final String? lastMessage;
  final List<String?> groupAvatars;
  final String? resolvedName;
  final String? lastMessageId;
  final String? resolvedAvatar;
  final List<String> groupMemberNames;

  RoomResponse({
    this.id,
    this.isGroup,
    this.createdAt,
    this.lastMessage,
    this.groupAvatars = const <String?>[],
    this.resolvedName,
    this.lastMessageId,
    this.resolvedAvatar,
    this.groupMemberNames = const <String>[],
  });

  factory RoomResponse.fromJson(Map<String, dynamic> json) {
    return RoomResponse(
      id: json['id'],
      isGroup: json['is_group'],
      createdAt: json['created_at'],
      lastMessage: json['last_message'],
      groupAvatars: json['group_avatars'] != null
          ? List<String?>.from(json['group_avatars'])
          : <String?>[],
      resolvedName: json['resolved_name'],
      lastMessageId: json['last_message_id'],
      resolvedAvatar: json['resolved_avatar'],
      groupMemberNames: json['group_member_names'] != null
          ? List<String>.from(json['group_member_names'])
          : <String>[],
    );
  }

  RoomEntity toEntity() {
    return RoomEntity(
      id: id,
      roomName: isGroup == true && resolvedName == null
       ? groupMemberNames.join(', ')
        : resolvedName,
      type: isGroup == true ? ChatType.group : ChatType.private,
      lastMessage: lastMessage != null
          ? MessageEntity(
              messageId: lastMessageId,
              context: lastMessage,
            )
          : null,
      avatarGroup: isGroup == true
      ? groupAvatars
      : <String?>[resolvedAvatar],
      isOnline: false, // Default value or update logic later
    );
  }
}
