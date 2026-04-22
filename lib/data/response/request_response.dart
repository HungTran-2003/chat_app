import 'package:chat_app/domain/models/entities/contact_entity.dart';
import 'package:chat_app/domain/models/enum/contact_status.dart';

class RequestResponse {
  final String? relationshipId;
  final String? receiverId;
  final String? status;
  final DateTime? updateAt;
  final String? greetingMessage;
  final String? username;
  final String? avatarUrl;

  const RequestResponse({
    this.relationshipId,
    this.receiverId,
    this.status,
    this.updateAt,
    this.greetingMessage,
    this.username,
    this.avatarUrl,
  });

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return RequestResponse(
      relationshipId: json['relationship_id'] as String?,
      receiverId: json['receiver_id'] as String?,
      status: json['status'] as String?,
      updateAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
      greetingMessage: json['greeting_message'] as String?,
      username: json['username'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationship_id': relationshipId,
      'receiver_id': receiverId,
      'status': status,
      'updated_at': updateAt?.toIso8601String(),
      'greeting_message': greetingMessage,
      'username': username,
      'avatar_url': avatarUrl,
    };
  }

  ContactEntity toEntity(){
    return ContactEntity(
      uid: relationshipId,
      requestId: receiverId,
      status: ContactStatus.fromString(status ?? ""),
      updateAt: updateAt,
      greetingMessage: greetingMessage,
      username: username,
      avatarUrl: avatarUrl,
    );
  }

}
