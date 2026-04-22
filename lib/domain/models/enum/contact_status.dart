enum ContactStatus {
  pending,
  accepted,
  blocked;

  static ContactStatus fromString(String value) {
    switch (value) {
      case "pending":
        return ContactStatus.pending;
      case "accepted":
        return ContactStatus.accepted;
      case "blocked":
        return ContactStatus.blocked;
      default:
        throw Exception("Invalid ContactStatus value: $value");
    }
  }
}

extension ContactStatusExt on ContactStatus {
  String get title {
    switch (this) {
      case ContactStatus.pending:
        return "pending";
      case ContactStatus.accepted:
        return "accepted";
      case ContactStatus.blocked:
        return "blocked";
    }
  }
}
