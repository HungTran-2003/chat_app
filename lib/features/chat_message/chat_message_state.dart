import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class ChatMessageState extends Equatable {
  final UserEntity? receiver;
  // TODO: Add message list entity

  const ChatMessageState({
    this.receiver,
  });

  @override
  List<Object?> get props => [receiver];

  ChatMessageState copyWith({
    UserEntity? receiver,
  }) {
    return ChatMessageState(
      receiver: receiver ?? this.receiver,
    );
  }
}
