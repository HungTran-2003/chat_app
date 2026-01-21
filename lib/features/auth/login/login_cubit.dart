import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/login/login_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginNavigator navigator;
  final AuthRepository authRepository;

  LoginCubit({required this.navigator, required this.authRepository})
    : super(const LoginState());

  ///Text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///Focus Node
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  ///Notifier
  final passwordNotifier = PasswordNotifier();
  final emailNotifier = TextFieldNotifier();

  void setStatusButtonLogin() {
    final hasTextEmail = AppValidator.validateEmpty(emailController.text);
    final hasTextPassword = AppValidator.validateEmpty(passwordController.text);
    final enable = hasTextEmail && hasTextPassword;
    emit(
      state.copyWith(
        buttonLoginStatus: state.buttonLoginStatus?.statusButton(enable),
      ),
    );
  }

  void cleanController() {
    emailController.clear();
    passwordController.clear();
  }

  void cleanFocusNode() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void cleanNotifier() {
    passwordNotifier.clear();
    emailNotifier.clear();
  }

  void loginByEmail() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    final email = emailController.text;
    final password = passwordController.text;
    final result = await authRepository.loginByEmail(
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
        cleanController();
        cleanFocusNode();
        navigator.goToHomePage();
      }
    );
  }
}
