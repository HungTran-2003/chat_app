part of 'register_cubit.dart';

class RegisterState extends Equatable {
  ///LoadStatus
  final LoadStatus? buttonSignUpStatus;

  const RegisterState({this.buttonSignUpStatus = LoadStatus.initial});

  @override
  List<Object?> get props => [buttonSignUpStatus];

  RegisterState copyWith({LoadStatus? buttonSignUpStatus}) {
    return RegisterState(
      buttonSignUpStatus: buttonSignUpStatus ?? this.buttonSignUpStatus,
    );
  }
}
