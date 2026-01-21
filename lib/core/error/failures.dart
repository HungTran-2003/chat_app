import 'dart:developer';
import 'dart:io';

import 'package:chat_app/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// ===============================
/// Base Failure
/// ===============================
abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
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

class FirebaseUnauthenticatedFailure extends FirebaseFailure {
  const FirebaseUnauthenticatedFailure({required super.message});
}

class FirebaseInvalidArgumentFailure extends FirebaseFailure {
  const FirebaseInvalidArgumentFailure({required super.message});
}

class FirebaseNotFoundFailure extends FirebaseFailure {
  const FirebaseNotFoundFailure({required super.message});
}

class FirebaseNetworkFailure extends FirebaseFailure {
  const FirebaseNetworkFailure({required super.message});
}

class FirebaseQuotaFailure extends FirebaseFailure {
  const FirebaseQuotaFailure({required super.message});
}

class FirebaseTimeoutFailure extends FirebaseFailure {
  const FirebaseTimeoutFailure({required super.message});
}

class FirebaseUnexpectedFailure extends FirebaseFailure {
  const FirebaseUnexpectedFailure({required super.message});
}

/// ===============================
/// Mapper
/// ===============================
class FirebaseFailureMapper {
  static Failure map(dynamic error) {
    log("Error: $error");

    /// Firebase Auth
    if (error is FirebaseAuthException) {
      return _mapAuthException(error);
    }

    /// Firestore
    if (error is FirebaseException) {
      return _mapFirestoreException(error);
    }

    /// Network
    if (error is SocketException) {
      return FirebaseNetworkFailure(
        message: S.current.common_message_network_error,
      );
    }

    return FirebaseUnexpectedFailure(
      message: S.current.common_message_unexpected_error,
    );
  }

  /// ===============================
  /// Firestore
  /// ===============================
  static Failure _mapFirestoreException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return FirebasePermissionFailure(
          message: S.current.common_message_permission_denied,
        );

      case 'unauthenticated':
        return FirebaseUnauthenticatedFailure(
          message: S.current.common_message_unauthenticated,
        );

      case 'invalid-argument':
        return FirebaseInvalidArgumentFailure(
          message: S.current.common_message_invalid_data,
        );

      case 'not-found':
        return FirebaseNotFoundFailure(
          message: S.current.common_message_data_not_found,
        );

      case 'already-exists':
        return FirebaseFailure(
          message: S.current.common_message_data_already_exists,
        );

      case 'resource-exhausted':
        return FirebaseQuotaFailure(
          message: S.current.common_message_quota_exceeded,
        );

      case 'deadline-exceeded':
        return FirebaseTimeoutFailure(
          message: S.current.common_message_timeout,
        );

      case 'unavailable':
        return FirebaseNetworkFailure(
          message: S.current.common_message_network_error,
        );

      default:
        return FirebaseUnexpectedFailure(
          message: e.message ??
              S.current.common_message_unexpected_error,
        );
    }
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
        return FirebaseUnexpectedFailure(
          message: e.message ??
              S.current.common_message_unexpected_error,
        );
    }
  }
}
