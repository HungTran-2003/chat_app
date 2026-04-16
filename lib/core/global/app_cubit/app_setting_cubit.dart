import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/domain/models/enum/language_type.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  void setCurrentUser({required UserEntity? user}) {
    emit(state.copyWith(currentUser: user));
  }

  void changeLanguage({required Language language}) {
    emit(state.copyWith(currentLanguage: language));
  }

  void logout() {
    emit(state.copyWith(
      currentUser: null,
    ));
  }
}
