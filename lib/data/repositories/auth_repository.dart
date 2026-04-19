import 'dart:developer';

import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/data/service/network/api_client.dart';
import 'package:chat_app/data/service/supabase/app_supabase_client.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, dynamic>> registerAccount({
    required String userName,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> loginWithGoogle(OAuthCredential credential);

  Future<Either<Failure, dynamic>> loginByEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getUserInfo();
  //
  // Future<Either<Failure, List<UserEntity>>> searchUser({
  //   required String keyword,
  //   int? limit = 20,
  // });
}

class AuthRepositoryImpl implements AuthRepository {
  final AppSupabaseClient client;
  AuthRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, dynamic>> registerAccount({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final user = await client.registerAccount(
        userName: userName,
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      log('Error signUp by email: $e');
      FirebaseAuth.instance.signOut();
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogle(
    OAuthCredential credential,
  ) async {
    try {
      final user = await client.loginWithGoogle(credential);
      return Right(user);
    } catch (e) {
      log('Error login by google: $e');
      FirebaseAuth.instance.signOut();
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, dynamic>> loginByEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await client.loginWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      log('Error login by email: $e');
      return Left(FailureMapper.map(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    try {
      final user = await client.getUserInfo();
      return Right(user);
    } catch (e) {
      log('Error get user info: $e');
      return Left(FailureMapper.map(e));
    }
  }
  //
  // @override
  // Future<Either<Failure, List<UserEntity>>> searchUser({
  //   required String keyword,
  //   int? limit = 20,
  // }) async {
  //   try{
  //     final result = await apiClient.searchUser(keyword: keyword, limit: limit);
  //     return Right(result);
  //   } catch (e) {
  //     log('Error search user: $e');
  //     return Left(FirebaseFailureMapper.map(e));
  //   }
  // }
}
