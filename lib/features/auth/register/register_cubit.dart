import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/register/register_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterNavigator navigator;
  final AuthRepository authRepository;

  RegisterCubit({required this.navigator, required this.authRepository})
      : super(const RegisterState());

  ///Text Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  ///Focus Node
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool setStatusButtonSignUp() {
    final hasTextEmail = AppValidator.validateEmpty(emailController.text);
    final hasTextPassword = AppValidator.validateEmpty(passwordController.text);
    final hasTextConfirmPassword =
        AppValidator.validateEmpty(confirmPasswordController.text);
    return hasTextEmail && hasTextPassword && hasTextConfirmPassword;

  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void setNameError(String? error) {
    emit(state.copyWith(nameError: error));
  }

  void setEmailError(String? error) {
    emit(state.copyWith(emailError: error));
  }

  void setPasswordError(String? error) {
    emit(state.copyWith(passwordError: error));
  }

  void setConfirmPasswordError(String? error) {
    emit(state.copyWith(confirmPasswordError: error));
  }

  void cleanController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emit(state.copyWith(
      nameError: null,
      emailError: null,
      passwordError: null,
      confirmPasswordError: null,
    ));
  }

  void cleanFocusNode() {
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  Future<void> registerAccount() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    final userName = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final result = await authRepository.registerAccount(
      userName: userName,
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(loadDataStatus: LoadStatus.success));
        navigator.showErrorDialog(message: "Login Failure");
      },
      (success) {
        emit(state.copyWith(loadDataStatus: LoadStatus.success));
        navigator.showSuccessSnackBar(message: '"Register Success"');
        cleanController();
        cleanFocusNode();
        navigator.goHome();
      },
    );
  }
}
