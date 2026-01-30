enum ChatType {
  private,
  group,
}

extension ChatTypeExton on ChatType {
  String get title {
    switch (this) {
      case ChatType.private:
        return "Private";
      case ChatType.group:
        return "Group";
    }
  }

  static ChatType fromString(String value) {
    switch (value) {
      case "Private":
        return ChatType.private;
      case "Group":
        return ChatType.group;
    }
    throw Exception("Invalid ChatType: $value");
  }
}