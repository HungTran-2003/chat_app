import 'package:chat_app/data/response/object_response.dart';
import 'package:chat_app/data/response/request_response.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AppSupabaseClient {
  Future<UserEntity> registerAccount({
    required String userName,
    required String email,
    required String password,
  });

  Future<UserEntity> loginWithGoogle(OAuthCredential credential);

  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserEntity> getUserInfo();

  Future<List<UserEntity>> searchUser({
    required String keyword,
    int? limit = 20,
    int? page = 1,
  });

  Future<List<RequestResponse>> getRequest({
    int? limit = 20,
    int? page = 1,
  });

  Future<ObjectResponse> sentContactRequest({
    required String receiverId,
    required String greetingMessage,
  });
}
