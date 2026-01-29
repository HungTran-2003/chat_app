part of 'message_cubit.dart';

class MessageState extends Equatable {

  ///LoadStatus
  final LoadStatus? loadDataStatus;
  final LoadStatus? loadContactStatus;

  ///Data
  final List<ChatEntity>? chats;
  final List<ContactEntity>? contacts;

  const MessageState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadContactStatus = LoadStatus.initial,
    this.chats = const [],
    this.contacts = const [],
  });

  @override
  List<Object?> get props => [loadDataStatus, loadContactStatus, chats, contacts];

  MessageState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadContactStatus,
    List<ChatEntity>? chats,
    List<ContactEntity>? contacts,
  }) {
    return MessageState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadContactStatus: loadContactStatus ?? this.loadContactStatus,
      chats: chats ?? this.chats,
      contacts: contacts ?? this.contacts,
    );
  }

}