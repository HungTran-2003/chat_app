import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    emit(state.copyWith(user: null));
  }
}
