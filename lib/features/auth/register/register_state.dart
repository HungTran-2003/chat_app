part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool enableSubmit;

  const RegisterState({
    this.loadDataStatus = LoadStatus.initial,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.enableSubmit = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        nameError,
        emailError,
        passwordError,
        confirmPasswordError,
        isPasswordVisible,
        isConfirmPasswordVisible,
        enableSubmit,
      ];

  RegisterState copyWith({
    LoadStatus? loadDataStatus,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? enableSubmit,
  }) {
    return RegisterState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      enableSubmit: enableSubmit ?? this.enableSubmit,
    );
  }
}
