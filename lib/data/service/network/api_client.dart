import 'package:dio/dio.dart';

/// Base API client interface for making HTTP requests in the application.
abstract class ApiClient {
  /// Makes a GET request to the specified [path] with optional [queryParameters].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Makes a POST request to the specified [path] with optional [data] and [queryParameters].
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Makes a PUT request to the specified [path] with optional [data] and [queryParameters].
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Makes a DELETE request to the specified [path] with optional [data] and [queryParameters].
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Makes a PATCH request to the specified [path] with optional [data] and [queryParameters].
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}
