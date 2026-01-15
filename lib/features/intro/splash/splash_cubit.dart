import 'package:chat_app/data/database/secure_storage_helper.dart';
import 'package:chat_app/features/intro/splash/spash_navigation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;

  SplashCubit({required this.navigator}) : super(const SplashState());

  void checkOnboard() async{
    final isFirstRun = await SecureStorageHelper.isFirstRun;
    if(isFirstRun){
      navigator.goToOnboarding();
      return;
    }
    _checkLogin();
  }
  void _checkLogin(){
    navigator.openLoginPage();
  }
}
