part of 'register_cubit.dart';

class RegisterState extends Equatable {
  ///LoadStatus
  final LoadStatus? buttonSignUpStatus;
  final LoadStatus? loadDataStatus;

  const RegisterState({
    this.buttonSignUpStatus = LoadStatus.initial,
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [buttonSignUpStatus, loadDataStatus];

  RegisterState copyWith({
    LoadStatus? buttonSignUpStatus,
    LoadStatus? loadDataStatus,
  }) {
    return RegisterState(
      buttonSignUpStatus: buttonSignUpStatus ?? this.buttonSignUpStatus,
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
