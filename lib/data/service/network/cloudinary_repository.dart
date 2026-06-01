import 'dart:async';
import 'package:dio/dio.dart';
import 'cloudinary_client.dart';
import 'cloudinary_upload_result.dart';
import 'upload_state.dart';

/// A repository interface to manage file uploads and expose clean Stream states.
class CloudinaryRepository {
  final CloudinaryClient _client;

  CloudinaryRepository({CloudinaryClient? client}) 
      : _client = client ?? CloudinaryClient();

  /// Uploads a file and yields a Stream of [UploadState] updates.
  ///
  /// This lets the UI layer or State Managers listen to the stream
  /// and update the progress bar or render successes/failures easily.
  Stream<UploadState> uploadFileStream({
    required String filePath,
    CancelToken? cancelToken,
  }) async* {
    yield const UploadInProgress(progress: 0.0, bytesSent: 0, totalBytes: 0);

    try {
      // Use controller to yield progress values
      final progressController = StreamController<UploadState>();

      _client.upload(
        filePath: filePath,
        cancelToken: cancelToken,
        onProgress: (sent, total, percentage) {
          progressController.add(
            UploadInProgress(
              progress: percentage,
              bytesSent: sent,
              totalBytes: total,
            ),
          );
        },
      ).then((result) {
        progressController.add(UploadSuccess(result));
        progressController.close();
      }).catchError((error) {
        final message = error is CloudinaryException ? error.message : error.toString();
        final code = error is CloudinaryException ? error.code : null;
        progressController.add(UploadFailure(message, code));
        progressController.close();
      });

      yield* progressController.stream;
    } catch (e) {
      yield UploadFailure("Failed to initialize upload stream: $e");
    }
  }

  /// Synchronous future-based upload helper
  Future<CloudinaryUploadResult> uploadFileDirect({
    required String filePath,
    void Function(double percentage)? onProgress,
    CancelToken? cancelToken,
  }) {
    return _client.upload(
      filePath: filePath,
      cancelToken: cancelToken,
      onProgress: (sent, total, percentage) {
        if (onProgress != null) {
          onProgress(percentage);
        }
      },
    );
  }
}
