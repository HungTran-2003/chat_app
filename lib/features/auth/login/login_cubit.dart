import 'package:chat_app/core/utlis/validator.dart';
import 'package:chat_app/domain/models/enum/status_type.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/features/auth/login/login_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  void setStatusButtonLogin() {
    final hasTextEmail = AppValidator.validateEmpty(emailController.text);
    final hasTextPassword = AppValidator.validateEmpty(passwordController.text);
    final enable = hasTextEmail && hasTextPassword;
    emit(
      state.copyWith(
        buttonLoginStatus: state.buttonLoginStatus.statusButton(enable),
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void setEmailError(String? error) {
    emit(state.copyWith(emailError: error));
  }

  void setPasswordError(String? error) {
    emit(state.copyWith(passwordError: error));
  }

  void cleanController() {
    emailController.clear();
    passwordController.clear();
    emit(state.copyWith(emailError: null, passwordError: null));
  }

  void cleanFocusNode() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
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
        emit(state.copyWith(loadDataStatus: LoadStatus.failure));
        navigator.showErrorSnackBar(message: failure.message);
      },
      (success) {
        emit(state.copyWith(loadDataStatus: LoadStatus.success));
        navigator.showSuccessSnackBar(message: "Login Success");
        cleanController();
        cleanFocusNode();
        navigator.goToHomePage();
      },
    );
  }

  void loginWithGoogle() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final result = await authRepository.loginWithGoogle(credential);
      result.fold(
        (error) {
          emit(state.copyWith(loadDataStatus: LoadStatus.failure));
          navigator.showSuccessSnackBar(message: "Login Cancel");
        },
        (success) {
          emit(state.copyWith(loadDataStatus: LoadStatus.success));
          navigator.showSuccessSnackBar(message: "Login Success");
          cleanController();
          cleanFocusNode();
          navigator.goToHomePage();
        },
      );
    } catch (e) {
      print(e.toString());
      navigator.showSuccessSnackBar(message: "Login Cancel");
    }
  }
}
