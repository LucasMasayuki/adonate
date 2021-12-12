import 'dart:async';

import 'package:adonate/shared/sharedPreferencesHelper.dart';
import 'package:adonate/shared/urls.dart';
import 'package:dio/dio.dart';

class DioAdapter {
  static Dio? client;
  static final DioAdapter _dioAdapter = DioAdapter._internal();

  factory DioAdapter() {
    client = new Dio();

    client?.options.baseUrl = Urls.baseUrl;
    return _dioAdapter;
  }

  DioAdapter._internal();

  static void _setClient(String? token) {
    final headers = <String, String?>{};

    headers['Authorization'] = 'Token ${token}';
    headers['Content-Type'] = 'application/json; charset=utf-8';

    client?.options.headers.addAll(headers);
  }

  Future<Response<T>?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    String? token = await SharedPreferencesHelper.get('token');
    _setClient(token);

    final response = await client?.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    return response as Response<T>;
  }

  Future<Response<T>> post<T>(
    String path, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    String? token = await SharedPreferencesHelper.get('token');
    if (token != null) {
      _setClient(token);
    }

    final response = await client?.post(
      path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response as Response<T>;
  }

  Future<Response<T>> delete<T>(
    String url, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    String? token = await SharedPreferencesHelper.get('token');
    _setClient(token);

    final response = await client?.delete(
      url,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

    return response as Response<T>;
  }

  Future<Response<T>?> put<T>(
    String url, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    String? token = await SharedPreferencesHelper.get('token');
    _setClient(token);

    final response = await client?.put(
      url,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return response as Response<T>;
  }

  dynamic handleResponse(Response? response) {}
}
