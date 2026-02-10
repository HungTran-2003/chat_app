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

  static List<ContactEntity> mockData() {
    return [
      ContactEntity(
        uid: '1',
        status: ContactStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updateAt: DateTime.now().subtract(const Duration(days: 5)),
        requestId: 'req-1',
        user: UserEntity(
          uid: 'user-1',
          userName: 'Alice',
          slogan: 'Live, laugh, love',
          avatarPath: 'https://i.pravatar.cc/150?u=alice',
          email: 'alice@email.com',
          role: 'user',
          backgroundColor: '#FFC107',
        ),
        greetingMessage: 'Hey, nice to meet you!',
      ),
      ContactEntity(
        uid: '2',
        status: ContactStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updateAt: DateTime.now().subtract(const Duration(days: 1)),
        requestId: 'req-2',
        user: UserEntity(
          uid: 'user-2',
          userName: 'Bob',
          slogan: 'Just do it.',
          avatarPath: 'https://i.pravatar.cc/150?u=bob',
          email: 'bob@email.com',
          role: 'user',
          backgroundColor: '#4CAF50',
        ),
        greetingMessage: 'Hi there!',
      ),
      ContactEntity(
        uid: '3',
        status: ContactStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updateAt: DateTime.now().subtract(const Duration(days: 15)),
        requestId: 'req-3',
        user: UserEntity(
          uid: 'user-3',
          userName: 'Charlie',
          slogan: 'Be yourself.',
          avatarPath: 'https://i.pravatar.cc/150?u=charlie',
          email: 'charlie@email.com',
          role: 'user',
          backgroundColor: '#F44336',
        ),
        greetingMessage: '',
      ),
      ContactEntity(
        uid: '4',
        status: ContactStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updateAt: DateTime.now().subtract(const Duration(days: 2)),
        requestId: 'req-4',
        user: UserEntity(
          uid: 'user-4',
          userName: 'Diana',
          slogan: 'Think different.',
          avatarPath: 'https://i.pravatar.cc/150?u=diana',
          email: 'diana@email.com',
          role: 'user',
          backgroundColor: '#2196F3',
        ),
        greetingMessage: 'Hello!',
      ),
      ContactEntity(
        uid: '5',
        status: ContactStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        updateAt: DateTime.now(),
        requestId: 'req-5',
        user: UserEntity(
          uid: 'user-5',
          userName: 'Eve',
          slogan: 'The journey is the reward.',
          avatarPath: 'https://i.pravatar.cc/150?u=eve',
          email: 'eve@email.com',
          role: 'user',
          backgroundColor: '#9C27B0',
        ),
        greetingMessage: 'Wanna chat?',
      ),
    ];
  }
}
