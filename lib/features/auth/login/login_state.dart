part of 'login_cubit.dart';

class LoginState extends Equatable {
  ///LoadStatus
  final LoadStatus? buttonLoginStatus;
  final LoadStatus? loadDataStatus;

  const LoginState({
    this.buttonLoginStatus = LoadStatus.initial,
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [buttonLoginStatus, loadDataStatus];

  LoginState copyWith({
    LoadStatus? buttonLoginStatus,
    LoadStatus? loadDataStatus,
  }) {
    return LoginState(
      buttonLoginStatus: buttonLoginStatus ?? this.buttonLoginStatus,
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
