class UserEntity {
  String? uid;
  String? userName;
  String? avatarPath;
  String? email;
  String? role;
  String? backgroundColor;

  UserEntity({
    this.uid,
    this.userName,
    this.avatarPath,
    this.email,
    this.role,
    this.backgroundColor,
});

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    uid: json["uid"],
    userName: json["user_name"],
    avatarPath: json["avatar_path"],
    email: json["email"],
    role: json["role"],
    backgroundColor: json["background_color"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "user_name": userName,
    "avatar_path": avatarPath,
    "email": email,
    "background_color": backgroundColor,
  };
}