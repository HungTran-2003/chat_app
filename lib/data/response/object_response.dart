class ObjectResponse {
  final bool? success;
  final String? message;
  final String? detail;

  const ObjectResponse({
    this.success = true,
    this.message,
    this.detail,
  });

  factory ObjectResponse.fromJson(Map<String, dynamic> json) {
    return ObjectResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
        detail: json['detail'] as String?,
    );
  }
}