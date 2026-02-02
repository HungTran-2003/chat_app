part of 'add_contact_cubit.dart';

class AddContactState extends Equatable {
  ///LoadStatus
  final LoadStatus? loadDataStatus;

  ///Param
  final String? keyWord;

  ///Data
  final List<UserEntity>? users;

  const AddContactState({this.loadDataStatus, this.keyWord, this.users = const []});

  @override
  List<Object?> get props => [loadDataStatus, keyWord, users];

  AddContactState copyWith({
    LoadStatus? loadDataStatus,
    String? keyWord,
    List<UserEntity>? users,
  }) {
    return AddContactState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      keyWord: keyWord ?? this.keyWord,
      users: users ?? this.users,
    );
  }
}
