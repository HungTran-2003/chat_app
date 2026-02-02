import 'package:chat_app/data/enum/contact_status.dart';
import 'package:chat_app/data/entities/user_entity.dart';

class ContactEntity {
  final String? uid;
  final ContactStatus? status;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final String? requestId;
  final UserEntity? user;
  final String? greetingMessage;

  const ContactEntity({
    this.uid,
    this.status,
    this.createdAt,
    this.updateAt,
    this.requestId,
    this.user,
    this.greetingMessage,
  });

  ContactEntity copyWith({
    String? uid,
    ContactStatus? status,
    DateTime? createdAt,
    DateTime? updateAt,
    String? requestId,
    UserEntity? user,
    String? greetingMessage,
  }) {
    return ContactEntity(
      uid: uid ?? this.uid,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      requestId: requestId ?? this.requestId,
      user: user ?? this.user,
      greetingMessage: greetingMessage ?? this.greetingMessage,
    );
  }
}
