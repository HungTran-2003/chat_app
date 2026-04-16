class UserEntity {
  String? uid;
  String? userName;
  String? slogan;
  String? avatarPath;
  String? email;
  String? role;
  String? backgroundColor;

  UserEntity({
    this.uid,
    this.userName,
    this.slogan,
    this.avatarPath,
    this.email,
    this.role,
    this.backgroundColor,
});

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    uid: json["uid"],
    userName: json["user_name"],
    slogan: json["slogan"],
    avatarPath: json["avatar_path"],
    email: json["email"],
    role: json["role"],
    backgroundColor: json["background_color"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "user_name": userName,
    "slogan": slogan,
    "avatar_path": avatarPath,
    "email": email,
    "background_color": backgroundColor,
  };
}