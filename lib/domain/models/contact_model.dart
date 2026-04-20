import 'package:chat_app/domain/models/entities/user_entity.dart';
import 'package:chat_app/domain/models/enum/contact_status.dart';

class ContactModel{
  final String? uid;
  final ContactStatus? status;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final String? requestId;
  final List<UserEntity>? user;
  final String? greetingMessage;

  const ContactModel({
    this.uid,
    this.status,
    this.createdAt,
    this.updateAt,
    this.requestId,
    this.user,
    this.greetingMessage,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      uid: json['uid'] as String?,
      status: json['status'] != null
          ? ContactStatus.fromString(json['status'])
          : ContactStatus.pending,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updateAt: json['update_at'] != null
          ? DateTime.tryParse(json['update_at'])
          : null,
      requestId: json['request_id'] as String?,
      user: (json['users'] as List<dynamic>?)
          ?.map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      greetingMessage: json['greeting_message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'status': status?.toString(),
    'created_at': createdAt?.toIso8601String(),
    'update_at': updateAt?.toIso8601String(),
    'request_id': requestId,
    'users': user?.map((e) => e.toJson()).toList() ?? '',
    'greeting_message': greetingMessage ?? 'Hello con chó'
  };


}