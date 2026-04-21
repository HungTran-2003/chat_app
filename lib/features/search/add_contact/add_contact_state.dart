part of 'add_contact_cubit.dart';

class AddContactState extends Equatable {
  ///LoadStatus
  final LoadStatus loadDataStatus;
  final LoadStatus loadRequestStatus;
  final LoadStatus loadStatus;


  ///Param
  final String? keyWord;

  ///Data
  final List<UserEntity> users;

  final List<ContactEntity> contacts;
  final List<ContactEntity> searchContacts;

  const AddContactState({
    this.loadDataStatus = LoadStatus.initial,
    this.loadRequestStatus = LoadStatus.initial,
    this.loadStatus = LoadStatus.initial,
    this.keyWord,
    this.users = const [],
    this.contacts = const [],
    this.searchContacts = const [],
  });

  @override
  List<Object?> get props => [
    loadDataStatus,
    loadStatus,
    loadRequestStatus,
    keyWord,
    users,
    contacts,
  ];

  AddContactState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? loadRequestStatus,
    LoadStatus? loadStatus,
    String? keyWord,
    List<UserEntity>? users,
    List<ContactEntity>? contacts,
    List<ContactEntity>? searchContacts,
  }) {
    return AddContactState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      loadRequestStatus: loadRequestStatus ?? this.loadRequestStatus,
      loadStatus: loadStatus ?? this.loadStatus,
      keyWord: keyWord ?? this.keyWord,
      users: users ?? this.users,
      contacts: contacts ?? this.contacts,
      searchContacts: searchContacts ?? this.searchContacts,
    );
  }
}
