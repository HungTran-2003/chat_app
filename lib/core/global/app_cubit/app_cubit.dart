import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/core/global/app_cubit/app_navigator.dart';
import 'package:chat_app/data/enum/language_type.dart';
import 'package:chat_app/data/enum/main_nav_item.dart';
import 'package:chat_app/data/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState>{
  late AppNavigator _navigator;
  AppCubit() : super(AppState());

  void setupNavigator(BuildContext context) {
    _navigator = AppNavigator(context: context);
  }

  void changeMainPage({required MainNavItem page}) {
    changePreviousMainPage(page: state.currentMainPage!);
    emit(state.copyWith(currentMainPage: page));
  }

  void changePreviousMainPage({required MainNavItem page}) {
    emit(state.copyWith(previousMainPage: page));
  }

  void setCurrentUser({required UserEntity user}) {
    emit(state.copyWith(currentUser: user));
  }
}