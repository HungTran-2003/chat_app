import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'cloudinary_upload_result.dart';

/// Custom Exception class for Cloudinary-related errors.
class CloudinaryException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  CloudinaryException(this.message, {this.code, this.statusCode});

  @override
  String toString() => 'CloudinaryException: $message (Status: $statusCode, Code: $code)';
}

/// A premium, production-ready Cloudinary upload client implemented using Dio.
///
/// Pre-configured with:
/// - Cloud Name: dhx0jghrl
/// - Upload Preset: ml_default
class CloudinaryClient {
  final Dio _dio;
  final String cloudName;
  final String uploadPreset;

  /// Creates a [CloudinaryClient] instance.
  ///
  /// You can pass a customized [Dio] client for interceptors, caching, etc.
  /// By default, it uses the provided credentials `dhx0jghrl` and `ml_default`.
  CloudinaryClient({
    Dio? dio,
    this.cloudName = 'dhx0jghrl',
    this.uploadPreset = 'ml_default',
  }) : _dio = dio ?? Dio();

  /// Automatically classifies file types to match Cloudinary's required resource types:
  /// - Images (.png, .jpg, .heic, etc.) -> 'image'
  /// - Videos (.mp4, .mov, etc.) & Audios/Voice Recordings (.m4a, .mp3, etc.) -> 'video'
  /// - Documents & other files (.pdf, .docx, .zip, etc.) -> 'raw'
  String _determineResourceType(String filePath) {
    final extension = p.extension(filePath).toLowerCase();

    // Standard list of extensions
    const imageExtensions = {'.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.heic', '.heif'};
    const videoExtensions = {'.mp4', '.mov', '.avi', '.mkv', '.webm', '.3gp'};
    const audioExtensions = {'.mp3', '.m4a', '.wav', '.aac', '.ogg', '.flac', '.amr'};

    if (imageExtensions.contains(extension)) {
      return 'image';
    } else if (videoExtensions.contains(extension) || audioExtensions.contains(extension)) {
      // Very Important: Cloudinary processes audios/voice recordings under the 'video' resource type
      return 'video';
    } else {
      return 'raw'; // PDF, Word documents, text files, ZIP archives, etc.
    }
  }

  /// Uploads any file (image, video, voice recording, documents) to Cloudinary.
  ///
  /// Features:
  /// - Automatic file classification (`image`, `video`, `raw`).
  /// - Accurate upload progress reporting.
  /// - Ability to cancel ongoing uploads via [CancelToken].
  ///
  /// Returns a [CloudinaryUploadResult] upon success.
  /// Throws a [CloudinaryException] on failure.
  Future<CloudinaryUploadResult> upload({
    required String filePath,
    void Function(int bytesSent, int totalBytes, double percentage)? onProgress,
    CancelToken? cancelToken,
  }) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw CloudinaryException("File does not exist at: $filePath");
    }

    final resourceType = _determineResourceType(filePath);
    final uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload';
    final fileName = p.basename(filePath);

    // Prepare multipart form data
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'upload_preset': uploadPreset,
    });

    try {
      final response = await _dio.post(
        uploadUrl,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: (sent, total) {
          if (total > 0 && onProgress != null) {
            final percentage = sent / total;
            onProgress(sent, total, percentage);
          }
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return CloudinaryUploadResult.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw CloudinaryException(
          "Failed to upload. Server responded with status code ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw CloudinaryException("Upload request cancelled by user.");
      }

      final responseData = e.response?.data;
      if (responseData is Map && responseData.containsKey('error')) {
        final errorMap = responseData['error'] as Map;
        final errorMessage = errorMap['message'] ?? 'Unknown Cloudinary error';
        throw CloudinaryException(
          errorMessage,
          statusCode: e.response?.statusCode,
          code: errorMap['code']?.toString(),
        );
      }

      throw CloudinaryException(
        "Network connection failed: ${e.message}",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      if (e is CloudinaryException) rethrow;
      throw CloudinaryException("An unexpected error occurred during upload: $e");
    }
  }
}
