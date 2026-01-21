import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/data/enum/status_type.dart';
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

  ///Notifier
  final nameNotifier = TextFieldNotifier();
  final passwordNotifier = PasswordNotifier();
  final emailNotifier = TextFieldNotifier();
  final confirmPasswordNotifier = PasswordNotifier();

  void setStatusButtonSignUp() {
    final hasTextEmail = AppValidator.validateEmpty(emailController.text);
    final hasTextPassword = AppValidator.validateEmpty(passwordController.text);
    final hasTextConfirmPassword = AppValidator.validateEmpty(
      confirmPasswordController.text,
    );
    final enable = hasTextEmail && hasTextPassword && hasTextConfirmPassword;
    emit(
      state.copyWith(
        buttonSignUpStatus: state.buttonSignUpStatus?.statusButton(enable),
      ),
    );
  }

  void cleanController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
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
        navigator.flushbarNavigator.showError(message: failure.message);
      },
      (success) {
        emit(state.copyWith(loadDataStatus: LoadStatus.success));
        navigator.appDialog.show(
          message: "Success",
          textConfirm: "Ok CC",
          onConfirm: () async {
            navigator.appDialog.hide();
            navigator.openLoginPage();
          },
        );
      },
    );
  }
}
