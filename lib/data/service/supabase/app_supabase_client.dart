import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppSupabaseClient {
  Future<UserEntity> registerAccount ({
    required String userName,
    required String email,
    required String password,
  });

  Future<UserEntity> loginWithGoogle(OAuthCredential credential);

}
