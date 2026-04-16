import 'package:chat_app/core/global/user/user_cubit.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/data/service/database/secure_storage_helper.dart';
import 'package:chat_app/features/intro/splash/spash_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepository;
  final UserCubit userCubit;

  SplashCubit({
    required this.navigator,
    required this.authRepository,
    required this.userCubit,
  }) : super(const SplashState());

  void checkOnboard() async {
    final isFirstRun = await SecureStorageHelper.isFirstRun;
    if (isFirstRun) {
      navigator.goToOnboarding();
      return;
    }
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      navigator.openLoginPage();
    } else {
      final result = await userCubit.fetchUserInfo();
      if(result) {
        navigator.goToHomePage();
      } else {
        navigator.showErrorSnackBar(message: "User not found");
        navigator.openLoginPage();
      }
    }
  }

}
