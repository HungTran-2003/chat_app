import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepository authRepository;

  UserCubit({required this.authRepository}) : super(const UserState());

  Future<bool> fetchUserInfo() async {
    final result = await authRepository.getUserInfo();

    result.fold((failure) {
      emit(state.copyWith(failure: failure));
      return false;
    }, (success) {
      emit(state.copyWith(user: success));
    });
    return true;
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await Supabase.instance.client.auth.signOut();
    emit(state.copyWith(user: null));
  }
}
