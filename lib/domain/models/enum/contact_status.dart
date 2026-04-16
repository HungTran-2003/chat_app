enum ContactStatus {
  pending,
  accepted,
  blocked;

  static ContactStatus fromString(String value) {
    switch (value) {
      case "Pending":
        return ContactStatus.pending;
      case "Accepted":
        return ContactStatus.accepted;
      case "Blocked":
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
        return "Pending";
      case ContactStatus.accepted:
        return "Accepted";
      case ContactStatus.blocked:
        return "Blocked";
    }
  }
}
