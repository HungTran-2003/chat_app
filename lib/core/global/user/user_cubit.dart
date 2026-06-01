import 'dart:developer';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepository authRepository;

  UserCubit({required this.authRepository}) : super(const UserState());

  Future<bool> fetchUserInfo() async {
    final result = await authRepository.getUserInfo();

    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure));
        return false;
      },
      (success) {
        emit(state.copyWith(user: success));
      },
    );
    return true;
  }

  Future<void> logOut() async {
    await Supabase.instance.client.auth.signOut();
    emit(state.copyWith(user: null));
  }

  void updateUserInfo(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  /// Updates the user profile in Supabase database and notifies all listeners.
  Future<bool> updateProfile({
    required String userName,
    required String slogan,
    String? avatarPath,
  }) async {
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) return false;

      // Update in Supabase profiles table
      await Supabase.instance.client.from('profiles').update({
        'username': userName,
        'slogan': slogan,
        if (avatarPath != null) 'avatar_url': avatarPath,
      }).eq('id', currentUser.id);

      // Construct the updated local UserEntity
      final updatedUser = UserEntity(
        uid: currentUser.id,
        userName: userName,
        slogan: slogan,
        avatarPath: avatarPath ?? state.user?.avatarPath,
        email: currentUser.email ?? state.user?.email,
        role: state.user?.role,
        backgroundColor: state.user?.backgroundColor,
      );
      
      emit(state.copyWith(user: updatedUser));
      return true;
    } catch (e) {
      log('Error updating profile in Supabase: $e');
      return false;
    }
  }
}
