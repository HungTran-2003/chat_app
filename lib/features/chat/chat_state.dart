part of 'chat_cubit.dart';

class ChatState extends Equatable {
  ///LoadStatus
  final LoadStatus? loadDataStatus;
  final LoadStatus? loadContactStatus;

  ///Data
  final List<RoomEntity>? rooms;
  final List<ContactEntity>? contacts;

  const ChatState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadContactStatus = LoadStatus.initial,
    this.rooms = const [],
    this.contacts = const [],
  });

  @override
  List<Object?> get props => [
    loadDataStatus,
    loadContactStatus,
    rooms,
    contacts,
  ];

  ChatState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadContactStatus,
    List<RoomEntity>? rooms,
    List<ContactEntity>? contacts,
  }) {
    return ChatState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadContactStatus: loadContactStatus ?? this.loadContactStatus,
      rooms: rooms ?? this.rooms,
      contacts: contacts ?? this.contacts,
    );
  }
}
