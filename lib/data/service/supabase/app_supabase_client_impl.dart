import 'dart:developer';

import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppSupabaseClientImpl implements AppSupabaseClient {
  final FirebaseAuth _auth;
  final SupabaseClient _client;

  AppSupabaseClientImpl({
    required FirebaseAuth auth,
    required SupabaseClient client,
  }) : _auth = auth,
       _client = client;

  @override
  Future<UserEntity> registerAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      final data = await _client
          .from('profiles')
          .insert({'id': user.uid, 'username': userName, 'email': email})
          .select()
          .single();
      return UserEntity.fromJson(data);
    } else {
      throw Exception('User is null');
    }
  }

  @override
  Future<UserEntity> loginWithGoogle(OAuthCredential credential) async {
    final UserCredential userCredential = await _auth.signInWithCredential(
      credential,
    );
    final user = userCredential.user;
    if (user == null) throw Exception('Firebase user is null');
    final data = await _client.rpc(
      'get_or_create_profile',
      params: {
        'uid': user.uid,
        'uname': user.displayName ?? "UnKnown",
        'uemail': user.email,
      },
    );
    log(data.toString());
    return UserEntity.fromJson(data);
  }

  @override
  Future<UserEntity> getUserInfo() async {
    final user = _auth.currentUser;
    final data = await _client
        .from('profiles')
        .select()
        .eq('id', user!.uid)
        .single();
    log(data.toString());
    return UserEntity.fromJson(data);
  }

  @override
  Future<List<UserEntity>> searchUser({
    required String keyword,
    int? limit = 10,
    int? page = 1,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final List<dynamic> response = await _client.rpc(
      'search_users_without_relationship',
      params: {
        'p_current_user_id': user.uid,
        'p_search': keyword,
        'p_limit': limit ?? 10,
        'p_page': page ?? 1,
      },
    );
    log(response.toString());

    return response.map((e) => UserEntity.fromJson(e)).toList();
  }
}
