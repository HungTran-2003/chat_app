import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getOtherUserInfo({required String userId});
}

class UserRepositoryImpl implements UserRepository {
  final AppSupabaseClient client;

  UserRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, UserEntity>> getOtherUserInfo({required String userId}) async {
    try {
      final user = await client.getOtherUserInfo(userId: userId);
      return Right(user);
    } catch (e) {
      log('Error get other user info: $e');
      return Left(FailureMapper.map(e));
    }
  }
}
