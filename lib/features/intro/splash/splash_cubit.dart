import 'package:chat_app/core/global/app_cubit/app_cubit.dart';
import 'package:chat_app/data/database/secure_storage_helper.dart';
import 'package:chat_app/data/entities/user_entity.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/features/intro/splash/spash_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepository;
  final AppCubit appCubit;

  SplashCubit({
    required this.navigator,
    required this.authRepository,
    required this.appCubit,
  }) : super(const SplashState());

  void checkOnboard() async {
    final isFirstRun = await SecureStorageHelper.isFirstRun;
    if (isFirstRun) {
      navigator.goToOnboarding();
      return;
    }
    _checkLogin();
    // appCubit.setCurrentUser(
    //   user: UserEntity(
    //     uid: "1",
    //     userName: "User 1",
    //     avatarPath: "https://i.pravatar.cc/150?u=alice",
    //   ),
    // );
    // navigator.goToHomePage();
  }

  void _checkLogin() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      navigator.openLoginPage();
    } else {
      _fetchData(user.uid);
    }
  }

  void _fetchData(String uid) async {
    final result = await authRepository.getUserInfo(uid: uid);

    await result.fold(
      (failure) {
        navigator.appDialog.show(
          message: failure.message,
          textConfirm: "Đăng nhập lại",
          onConfirm: () async {
            navigator.appDialog.hide();
            navigator.openLoginPage();
          },
        );
      },
      (success) {
        appCubit.setCurrentUser(
          user: UserEntity(uid: "1", userName: "User 1"),
        );
        navigator.goToHomePage();
      },
    );
  }
}
