part of 'login_cubit.dart';

class LoginState extends Equatable {
  ///LoadStatus
  final LoadStatus? buttonLoginStatus;

  const LoginState({this.buttonLoginStatus = LoadStatus.initial});

  @override
  List<Object?> get props => [buttonLoginStatus];

  LoginState copyWith({
    LoadStatus? buttonLoginStatus,
  }) {
    return LoginState(
      buttonLoginStatus: buttonLoginStatus ?? this.buttonLoginStatus,
    );
  }
}
