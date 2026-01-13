
import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/core/global/app_cubit/app_navigator.dart';
import 'package:chat_app/data/models/enum/language_type.dart';
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
}