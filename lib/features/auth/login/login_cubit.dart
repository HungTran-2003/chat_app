import 'package:chat_app/features/auth/login/login_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  final LoginNavigator navigator;

  LoginCubit({required this.navigator}) : super(const LoginState());


}