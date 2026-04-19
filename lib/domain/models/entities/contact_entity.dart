import 'package:chat_app/domain/models/enum/contact_status.dart';
import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String? uid;
  final ContactStatus? status;
  final DateTime? updateAt;
  final String? requestId;
  final String? greetingMessage;
  final String? username;
  final String? avatarUrl;

  const ContactEntity({
    this.uid,
    this.status,
    this.updateAt,
    this.requestId,
    this.username,
    this.avatarUrl,
    this.greetingMessage,
  });

  ContactEntity copyWith({
    String? uid,
    ContactStatus? status,
    DateTime? updateAt,
    String? requestId,
    String? username,
    String? avatarUrl,
    String? greetingMessage,
  }) {
    return ContactEntity(
      uid: uid ?? this.uid,
      status: status ?? this.status,
      updateAt: updateAt ?? this.updateAt,
      requestId: requestId ?? this.requestId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      greetingMessage: greetingMessage ?? this.greetingMessage,
    );
  }

  @override
  List<Object?> get props => [
    uid,
    status,
    updateAt,
    requestId,
    username,
    avatarUrl,
    greetingMessage,
  ];
}
