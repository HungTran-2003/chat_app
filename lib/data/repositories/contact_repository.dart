import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/response/object_response.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<Failure, List<UserEntity>>> searchUser(
    String keyword, {
    int? limit,
    int? page,
  });

  Future<Either<Failure, List<ContactEntity>>> getRecentContacts({
    int? limit,
    int? page,
  });

  Future<Either<Failure, ObjectResponse>> sentContactRequest({
    required String receiverId,
    required String greetingMessage,
  });

  Future<Either<Failure, ObjectResponse>> acceptRequest({
    required String requestId,
  });

  Future<Either<Failure, ObjectResponse>> ignoreRequest({
    required String requestId,
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

  @override
  Future<Either<Failure, List<ContactEntity>>> getRecentContacts({
    int? limit,
    int? page,
  }) async {
    try {
      final result = await client.getRequest(limit: limit, page: page);

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      log('Error search user: $e');
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ObjectResponse>> sentContactRequest({
    required String receiverId,
    required String greetingMessage,
  }) async {
    try {
      final result = await client.sentContactRequest(
        receiverId: receiverId,
        greetingMessage: greetingMessage,
      );
      return Right(result);
    } catch (e) {
      log('Error search user: $e');
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ObjectResponse>> acceptRequest({
    required String requestId,
  }) async {
    try {
      final result = await client.acceptRequest(requestId: requestId);
      return Right(result);
    } catch (e) {
      log('Error search user: $e');
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, ObjectResponse>> ignoreRequest({
    required String requestId,
  }) async {
    try {
      final result = await client.ignoreRequest(requestId: requestId);
      return Right(result);
    } catch (e) {
      log('Error search user: $e');
      return Left(FailureMapper.map(e));
    }
  }
}
