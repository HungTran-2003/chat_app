/// Model representing the response from Cloudinary API after a successful upload.
class CloudinaryUploadResult {
  final String secureUrl;
  final String publicId;
  final String resourceType;
  final int bytes;
  final String format;
  final DateTime createdAt;

  CloudinaryUploadResult({
    required this.secureUrl,
    required this.publicId,
    required this.resourceType,
    required this.bytes,
    required this.format,
    required this.createdAt,
  });

  factory CloudinaryUploadResult.fromJson(Map<String, dynamic> json) {
    return CloudinaryUploadResult(
      secureUrl: json['secure_url'] as String,
      publicId: json['public_id'] as String,
      resourceType: json['resource_type'] as String,
      bytes: json['bytes'] as int,
      format: json['format'] ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'secure_url': secureUrl,
      'public_id': publicId,
      'resource_type': resourceType,
      'bytes': bytes,
      'format': format,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'CloudinaryUploadResult(secureUrl: $secureUrl, publicId: $publicId, resourceType: $resourceType, bytes: $bytes)';
  }
}
