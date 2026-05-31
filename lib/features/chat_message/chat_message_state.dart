import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:chat_app/domain/models/entities/room_entity.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:equatable/equatable.dart';

class ChatMessageState extends Equatable {
  final UserEntity? receiver;
  final List<MessageEntity>? messages;
  final LoadStatus loadMessagesStatus;
  final LoadStatus sendMessageStatus;
  final RoomEntity? room;

  const ChatMessageState({
    this.receiver,
    this.messages,
    this.loadMessagesStatus = LoadStatus.initial,
    this.sendMessageStatus = LoadStatus.initial,
    this.room,
  });

  @override
  List<Object?> get props => [
        receiver,
        messages,
        loadMessagesStatus,
        sendMessageStatus,
        room,
      ];

  ChatMessageState copyWith({
    UserEntity? receiver,
    List<MessageEntity>? messages,
    LoadStatus? loadMessagesStatus,
    LoadStatus? sendMessageStatus,
    RoomEntity? room,
  }) {
    return ChatMessageState(
      receiver: receiver ?? this.receiver,
      messages: messages ?? this.messages,
      loadMessagesStatus: loadMessagesStatus ?? this.loadMessagesStatus,
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      room: room ?? this.room,
    );
  }
}
