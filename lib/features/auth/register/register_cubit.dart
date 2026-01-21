import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/core/widgets/text_field/app_text_field.dart';
import 'package:chat_app/core/widgets/text_field/password_text_field.dart';
import 'package:chat_app/data/enum/status_type.dart';
import 'package:chat_app/features/auth/register/register_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterNavigator navigator;

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

  RegisterCubit({required this.navigator}) : super(const RegisterState());

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
}
