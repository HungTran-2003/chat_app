import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/api_client.dart';
import 'package:chat_app/data/models/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> registerAccount({
    required String userName,
    required String email,
    required String password,
  });

  Future<Either<Failure, dynamic>> loginByEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getUserInfo({required String uid});
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, dynamic>> registerAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final user = await apiClient.registerAccount(
        userName: userName,
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      log('Error login by email: $e');
      return Left(FirebaseFailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> loginByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await apiClient.loginByEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      log('Error login by email: $e');
      return Left(FirebaseFailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInfo({required String uid}) async {
    try {
      final user = await apiClient.getUserInfo(uid: uid);
      return Right(user);
    } catch (e) {
      log('Error get user info: $e');
      return Left(FirebaseFailureMapper.map(e));
    }
  }
}
