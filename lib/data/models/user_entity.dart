class UserEntity {
  String? uid;
  String? userName;
  String? avatarPath;
  String? email;

  UserEntity({
    this.uid,
    this.userName,
    this.avatarPath,
    this.email,
});

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    uid: json["uid"],
    userName: json["user_name"],
    avatarPath: json["avatar_path"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "user_name": userName,
    "avatar_path": avatarPath,
    "email": email,
  };
}