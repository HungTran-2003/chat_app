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
    uid: json["id"],
    userName: json["username"],
    slogan: json["slogan"],
    avatarPath: json["avatar_url"],
    email: json["email"],
    role: json["role"],
    backgroundColor: json["background_color"],
  );

  Map<String, dynamic> toJson() => {
    "id": uid,
    "username": userName,
    "slogan": slogan,
    "avatar_url": avatarPath,
    "email": email,
    "background_color": backgroundColor,
  };
}