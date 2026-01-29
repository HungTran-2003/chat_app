import 'package:chat_app/data/enum/contact_status.dart';
import 'package:chat_app/data/models/user_entity.dart';

class ContactEntity {
  final List<String>? ids;
  final ContactStatus? status;
  final String? createdAt;
  final String? updateAt;
  final int? requestId;
  final List<UserEntity>? users;

  const ContactEntity({
    this.ids,
    this.status,
    this.createdAt,
    this.updateAt,
    this.requestId,
    this.users,
  });

  static List<ContactEntity> mockData() {
    return [
      ContactEntity(
        ids: ["1", "2"],
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "2",
            userName: "User 2",
            avatarPath: "https://i.pravatar.cc/150?u=bob",
          ),
        ],
      ),
      ContactEntity(
        ids: ["1", "3"],
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "3",
            userName: "User 3",
            avatarPath: "https://i.pravatar.cc/150?u=charlie",
          ),
        ],
      ),
      ContactEntity(
        ids: ["1", "4"],
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "4",
            userName: "User 4",
            avatarPath: "https://i.pravatar.cc/150?u=david",
          ),
        ],
      ),
      ContactEntity(
        ids: ["1", "5"],
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "5",
            userName: "User 5",
            avatarPath: "https://i.pravatar.cc/150?u=eve",
          ),
        ],
      ),
      ContactEntity(
        ids: ["1", "6"],
        status: ContactStatus.accepted,
        createdAt: "2023-07-20",
        updateAt: "2023-07-20",
        requestId: 1,
        users: [
          UserEntity(
            uid: "1",
            userName: "User 1",
            avatarPath: "https://i.pravatar.cc/150?u=alice",
          ),
          UserEntity(
            uid: "6",
            userName: "User 6",
            avatarPath: "https://i.pravatar.cc/150?u=frank",
          ),
        ],
      ),
    ];
  }
}
