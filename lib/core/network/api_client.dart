import 'package:chat_app/data/models/user_entity.dart';

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
}
