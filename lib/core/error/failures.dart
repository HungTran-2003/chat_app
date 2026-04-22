import 'dart:developer';
import 'dart:io';

import 'package:chat_app/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// ===============================
/// Base Failure
/// ===============================
abstract class Failure extends Equatable {
  final String message;
  final int? code;


  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// ===============================
/// Common Failures
/// ===============================
class CommonFailure extends Failure {
  const CommonFailure({required super.message});
}

class NetworkFailure extends CommonFailure {
  const NetworkFailure({required super.message});
}

class UnexpectedFailure extends CommonFailure {
  const UnexpectedFailure({required super.message});
}

/// ===============================
/// Firebase Failures
/// ===============================
class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message});
}

class FirebasePermissionFailure extends FirebaseFailure {
  const FirebasePermissionFailure({required super.message});
}

/// ===============================
/// Supabase Failures
/// ===============================
class SupabaseFailure extends Failure {
  const SupabaseFailure({required super.message, super.code});
}

/// ===============================
/// Mapper
/// ===============================
class FailureMapper {
  static Failure map(dynamic error) {
    log("Error: $error");

    /// Firebase Auth
    if (error is FirebaseAuthException) {
      return _mapAuthException(error);
    }

    /// Supabase
    if (error is AuthException) {
      return SupabaseFailure(message: error.message);
    }
    
    if (error is PostgrestException) {
      return SupabaseFailure(message: error.message);
    }

    /// Network
    if (error is SocketException) {
      return NetworkFailure(
        message: S.current.common_message_network_error,
      );
    }

    return UnexpectedFailure(
      message: S.current.common_message_unexpected_error,
    );
  }

  /// ===============================
  /// Firebase Auth
  /// ===============================
  static Failure _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return FirebaseFailure(
          message: S.current.common_message_user_not_found,
        );

      case 'wrong-password':
        return FirebaseFailure(
          message: S.current.common_message_wrong_password,
        );

      case 'invalid-email':
        return FirebaseFailure(
          message: S.current.common_message_invalid_email,
        );

      case 'user-disabled':
        return FirebaseFailure(
          message: S.current.common_message_user_disabled,
        );

      default:
        return FirebaseFailure(
          message: e.message ?? S.current.common_message_unexpected_error,
        );
    }
  }
}
