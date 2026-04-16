part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final Failure? failure;

  const UserState({this.user, this.failure});

  @override
  List<Object?> get props => [user, failure];

  UserState copyWith({UserEntity? user, Failure? failure}) {
    return UserState(user: user ?? this.user, failure: failure ?? this.failure);
  }
}
