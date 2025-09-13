import 'dart:io';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://caseapi.servicelabs.tech',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> postMultipart(
    String path, {
    required File file,
    String fileField = 'file',
    Map<String, dynamic>? headers,
  }) async {
    final formData = FormData.fromMap({
      fileField: await MultipartFile.fromFile(file.path),
    });
    return await _dio.post(path, data: formData, options: Options(headers: headers));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.post(path, data: data, options: Options(headers: headers));
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.put(path, data: data, options: Options(headers: headers));
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.delete(path, options: Options(headers: headers));
  }
}