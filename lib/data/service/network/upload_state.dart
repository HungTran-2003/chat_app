import 'cloudinary_upload_result.dart';

/// Sealed class to represent the lifecycle of a file upload.
///
/// Pattern matching (switch-expression) in Dart 3 can be used on this
/// to enforce compile-time exhaustive checks in the UI layer.
sealed class UploadState {
  const UploadState();
}

/// The upload has not started yet.
class UploadIdle extends UploadState {
  const UploadIdle();
}

/// The upload is actively in progress.
class UploadInProgress extends UploadState {
  /// The progress value, normalized between 0.0 (0%) and 1.0 (100%).
  final double progress;

  /// Number of bytes successfully sent so far.
  final int bytesSent;

  /// Total number of bytes to send.
  final int totalBytes;

  const UploadInProgress({
    required this.progress,
    required this.bytesSent,
    required this.totalBytes,
  });

  @override
  String toString() => 'UploadInProgress(progress: ${(progress * 100).toStringAsFixed(1)}%)';
}

/// The file was successfully uploaded to Cloudinary.
class UploadSuccess extends UploadState {
  final CloudinaryUploadResult result;

  const UploadSuccess(this.result);

  @override
  String toString() => 'UploadSuccess(url: ${result.secureUrl})';
}

/// The file upload failed due to network or server error.
class UploadFailure extends UploadState {
  final String errorMessage;
  final String? errorCode;

  const UploadFailure(this.errorMessage, [this.errorCode]);

  @override
  String toString() => 'UploadFailure(error: $errorMessage)';
}
