import 'package:chat_app/data/entities/contact_entity.dart';
import 'package:chat_app/data/entities/user_entity.dart';

abstract class ApiClient {
  Future<dynamic> registerAccount ({
    required String userName,
    required String email,
    required String password,
  });

  Future<dynamic> loginByEmail({
    required String email,
    required String password,
  });

  Future<UserEntity> getUserInfo({required String uid});

  Future<ContactEntity> createContact({required UserEntity contactUser, required UserEntity currentUser});

  Future<List<UserEntity>> searchUser({required String keyword, required int? limit});
}
