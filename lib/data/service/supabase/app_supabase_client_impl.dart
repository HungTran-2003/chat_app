import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/response/object_response.dart';
import 'package:chat_app/data/response/request_response.dart';
import 'package:chat_app/data/response/room_response.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/entities/message_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' hide OAuthProvider;
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
    // Đăng ký trực tiếp trên Supabase Auth và truyền kèm metadata username
    final authResponse = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'username': userName},
    );
    final user = authResponse.user;
    if (user != null) {
      return getUserInfo();
    } else {
      throw Exception('Supabase user is null after signup');
    }
  }

  @override
  Future<UserEntity> loginWithGoogle(OAuthCredential credential) async {
    // Đăng nhập Firebase chỉ để lấy ID Token của Google
    final UserCredential userCredential = await _auth.signInWithCredential(
      credential,
    );
    final user = userCredential.user;
    if (user == null) throw Exception('Firebase user is null');

    // Sử dụng Google ID Token để đăng nhập trực tiếp vào Supabase Auth
    final String? googleIdToken = credential.idToken;
    if (googleIdToken != null) {
      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleIdToken,
      );
    }

    final supabaseUser = _client.auth.currentUser;
    if (supabaseUser == null) throw Exception('Supabase user is null after Google OIDC');

    final data = await _client.rpc(
      'get_or_create_profile',
      params: {
        'uid': supabaseUser.id,
        'uname': user.displayName ?? "UnKnown",
        'uemail': user.email,
      },
    );
    log(data.toString());
    return UserEntity.fromJson(data);
  }

  @override
  Future<UserEntity> getUserInfo() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');
    final data = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
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
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final List<dynamic> response = await _client.rpc(
      'search_users_without_relationship',
      params: {
        'p_current_user_id': user.id,
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
    await _client.auth.signInWithPassword(email: email, password: password);
    return getUserInfo();
  }

  @override
  Future<List<RequestResponse>> getRequest({
    int? limit = 20,
    int? page = 1,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final List<dynamic> response = await _client.rpc(
      'get_incoming_friend_requests',
      params: {
        'p_user_id': user.id,
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
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'send_contact_request',
      params: {
        'p_sender_id': user.id,
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
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'accept_contact_request',
      params: {'p_request_id': requestId, 'p_user_id': user.id},
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  @override
  Future<ObjectResponse> ignoreRequest({required String requestId}) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'ignore_contact_request',
      params: {'p_request_id': requestId, 'p_user_id': user.id},
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  @override
  Future<List<UserEntity>> getFriends({
    int? limit = 20,
    int? page = 1,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'get_friends',
      params: {
        'p_user_id': user.id,
        'p_limit': limit,
        'p_page': page,
      },
    );
    final List<dynamic> data = response;
    return data.map((e) => UserEntity.fromJson(e)).toList();
  }

  @override
  Future<ObjectResponse> addFcmToken({
    required String deviceId,
    required String fcmToken,
    required String platform,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'add_fcm_token',
      params: {
        'p_user_id': user.id,
        'p_device_id': deviceId,
        'p_fcm_token': fcmToken,
        'p_platform': platform,
      },
    );
    final data = _processResponse(response);
    return ObjectResponse.fromJson(data);
  }

  @override
  Future<List<RoomResponse>> getUserRooms() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final response = await _client.rpc(
      'get_user_rooms',
      params: {
        'p_user_id': user.id,
      },
    );
    final List<dynamic> data = response;
    log(data.toString());
    return data.map((e) => RoomResponse.fromJson(e)).toList();
  }

  @override
  Stream<List<RoomResponse>> getUserRoomsRealtime() {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return Stream.value([]);

    return _client
        .from('rooms')
        .stream(primaryKey: ['id'])
        .asyncMap((event) => getUserRooms());
  }

  @override
  Stream<List<MessageEntity>> getRoomMessagesRealtime({required String roomId}) {
    return _client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at', ascending: true)
        .map((event) {
          return event.map((json) {
            return MessageEntity(
              messageId: json['id'],
              senderId: json['sender_id'],
              context: json['content'],
              createdAt: json['created_at'],
              attachPath: json['file_url'] != null ? [json['file_url']] : null,
            );
          }).toList();
        });
  }

  @override
  Future<void> sendMessage({required String roomId, required String content}) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    await _client.from('messages').insert({
      'room_id': roomId,
      'sender_id': userId,
      'content': content,
      'type': 'text',
    });
  }
}
