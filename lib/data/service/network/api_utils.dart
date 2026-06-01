import 'package:dio/dio.dart';

/// Utilities for parsing API errors and networking helpers.
class ApiUtils {
  ApiUtils._();

  /// Converts a [DioException] into a user-friendly error message string.
  static String getFriendlyErrorMessage(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return 'Kết nối mạng quá hạn. Vui lòng kiểm tra lại đường truyền internet.';
      case DioExceptionType.sendTimeout:
        return 'Gửi dữ liệu quá hạn. Vui lòng thử lại.';
      case DioExceptionType.receiveTimeout:
        return 'Phản hồi từ máy chủ quá hạn. Vui lòng thử lại sau.';
      case DioExceptionType.badCertificate:
        return 'Chứng chỉ bảo mật không hợp lệ.';
      case DioExceptionType.badResponse:
        final statusCode = dioException.response?.statusCode;
        final responseData = dioException.response?.data;
        if (responseData is Map && responseData.containsKey('message')) {
          return responseData['message']?.toString() ?? 'Lỗi từ máy chủ ($statusCode)';
        }
        return 'Yêu cầu không thành công với lỗi từ máy chủ ($statusCode).';
      case DioExceptionType.cancel:
        return 'Yêu cầu đã bị hủy bỏ.';
      case DioExceptionType.connectionError:
        return 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra internet.';
      case DioExceptionType.unknown:
        return 'Đã xảy ra lỗi kết nối không xác định. Vui lòng thử lại.';
    }
  }
}
