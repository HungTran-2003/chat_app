class MessageEntity {
  final String? messageId;
  final String? senderId;
  final String? context;
  final MessageEntity? replyMessage;
  final List<String>? attachPath;
  final bool? isDelete;
  final String? createdAt;

  const MessageEntity({
    this.messageId,
    this.senderId,
    this.context,
    this.replyMessage,
    this.attachPath,
    this.isDelete,
    this.createdAt,
  });
}
