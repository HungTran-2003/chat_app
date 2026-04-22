import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/response/object_response.dart';
import 'package:chat_app/data/response/request_response.dart';
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
  Future<UserEntity> getOtherUserInfo({required String userId}) async {
    final data = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
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

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    return getUserInfo();
  }

  @override
  Future<List<RequestResponse>> getRequest({
    int? limit = 20,
    int? page = 1,
  }) async {
    final List<dynamic> response = await _client.rpc(
      'get_incoming_friend_requests',
      params: {
        'p_user_id': _auth.currentUser!.uid,
        'p_limit': limit ?? 10,
        'p_page': page ?? 1,
      },
    );
    return response.map((e) => RequestResponse.fromJson(e)).toList();
  }

  @override
  Future<ObjectResponse> sentContactRequest({
    required String receiverId,
    required String greetingMessage,
  }) async {
    final response = await _client.rpc(
      'send_contact_request',
      params: {
        'p_sender_id': _auth.currentUser!.uid,
        'p_receiver_id': receiverId,
        'p_greeting': greetingMessage,
      },
    );
    log(response.toString());

    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  dynamic _processResponse(dynamic response) {
    if (response is Map && response.containsKey('success')) {
      if (response['success'] == false) {
        throw SupabaseFailure(
          message: response['message'],
          code: response['code'],
        );
      }
      return response;
    }
    return response;
  }

  @override
  Future<ObjectResponse> acceptRequest({required String requestId}) async {
    final response = await _client.rpc(
      'accept_contact_request',
      params: {'p_request_id': requestId, 'p_user_id': _auth.currentUser!.uid},
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  @override
  Future<ObjectResponse> ignoreRequest({required String requestId}) async {
    final response = await _client.rpc(
      'ignore_contact_request',
      params: {'p_request_id': requestId, 'p_user_id': _auth.currentUser!.uid},
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  @override
  Future<ObjectResponse> addFcmToken({
    required String deviceId,
    required String fcmToken,
    required String platform,
  }) async {
    final response = await _client.rpc(
      'add_fcm_token',
      params: {
        'p_user_id': _auth.currentUser!.uid,
        'p_device_id': deviceId,
        'p_fcm_token': fcmToken,
        'p_platform': platform,
      },
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }
}
