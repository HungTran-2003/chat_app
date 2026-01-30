import 'package:chat_app/data/enum/contact_status.dart';
import 'package:chat_app/data/models/user_entity.dart';

class ContactEntity {
  final String? uid;
  final ContactStatus? status;
  final String? createdAt;
  final String? updateAt;
  final int? requestId;
  final UserEntity? user;

  const ContactEntity({
    this.uid,
    this.status,
    this.createdAt,
    this.updateAt,
    this.requestId,
    this.user,
  });

  static List<ContactEntity> mockData() {
    return [
      ContactEntity(
        uid: "1",
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        user: UserEntity(
            uid: "2",
            userName: "User 2",
            avatarPath: "https://i.pravatar.cc/150?u=bob",
            backgroundColor: "Red"
        ),
      ),
      ContactEntity(
        uid: "2",
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        user: UserEntity(
          uid: "3",
          userName: "User 3",
          avatarPath: "https://i.pravatar.cc/150?u=charlie",
        ),
      ),
      ContactEntity(
        uid: "3",
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        user: UserEntity(
          uid: "4",
          userName: "User 4",
          avatarPath: "https://i.pravatar.cc/150?u=david",
        ),
      ),
      ContactEntity(
        uid: "4",
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        user: UserEntity(
          uid: "5",
          userName: "User 5",
          avatarPath: "https://i.pravatar.cc/150?u=eve",
        ),
      ),
      ContactEntity(
        uid: "5",
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        user: UserEntity(
          uid: "6",
          userName: "User 6",
          avatarPath: "https://i.pravatar.cc/150?u=frank",
        ),
      ),
    ];
  }
}
