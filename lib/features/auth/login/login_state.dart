part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus buttonLoginStatus;
  final LoadStatus loadDataStatus;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible;

  const LoginState({
    this.buttonLoginStatus = LoadStatus.initial,
    this.loadDataStatus = LoadStatus.initial,
    this.emailError,
    this.passwordError,
    this.isPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
        buttonLoginStatus,
        loadDataStatus,
        emailError,
        passwordError,
        isPasswordVisible,
      ];

  LoginState copyWith({
    LoadStatus? buttonLoginStatus,
    LoadStatus? loadDataStatus,
    String? emailError,
    String? passwordError,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      buttonLoginStatus: buttonLoginStatus ?? this.buttonLoginStatus,
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
