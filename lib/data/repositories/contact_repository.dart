import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<UserEntity>>> searchUser(
    String keyword, {
    int? limit,
    int? page,
  });
}

class ContactRepositoryImpl implements ContactRepository {
  final AppSupabaseClient client;

  ContactRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, List<UserEntity>>> searchUser(
    String keyword, {
    int? limit,
    int? page,
  }) async {
    try {
      final result = await client.searchUser(
        keyword: keyword,
        limit: limit,
        page: page,
      );
      return Right(result);
    } catch (e) {
      log('Error search user: $e');
      return Left(FailureMapper.map(e));
    }
  }
}
