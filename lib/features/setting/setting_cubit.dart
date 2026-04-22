import 'package:chat_app/features/setting/setting_navigator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingNavigator navigator;

  SettingCubit(this.navigator) : super(const SettingState());

  void logOut(){

  }
}