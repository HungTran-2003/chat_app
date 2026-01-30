part of 'chat_cubit.dart';

class ChatState extends Equatable {

  ///LoadStatus
  final LoadStatus? loadDataStatus;
  final LoadStatus? loadContactStatus;

  ///Data
  final List<ChatEntity>? chats;
  final List<ContactEntity>? contacts;

  const ChatState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadContactStatus = LoadStatus.initial,
    this.chats = const [],
    this.contacts = const [],
  });

  @override
  List<Object?> get props => [loadDataStatus, loadContactStatus, chats, contacts];

  ChatState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadContactStatus,
    List<ChatEntity>? chats,
    List<ContactEntity>? contacts,
  }) {
    return ChatState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadContactStatus: loadContactStatus ?? this.loadContactStatus,
      chats: chats ?? this.chats,
      contacts: contacts ?? this.contacts,
    );
  }

}