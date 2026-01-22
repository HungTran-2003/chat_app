part of 'message_cubit.dart';

class MessageState extends Equatable {

  ///LoadStatus
  final LoadStatus? loadDataStatus;

  ///Data
  final List<ChatEntity>? chats;

  const MessageState({
    this.loadDataStatus = LoadStatus.initial,
    this.chats = const [],
  });

  @override
  List<Object?> get props => [loadDataStatus, chats];

  MessageState copyWith({
    LoadStatus? loadDataStatus,
    List<ChatEntity>? chats,
  }) {
    return MessageState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      chats: chats ?? this.chats,
    );
  }

}