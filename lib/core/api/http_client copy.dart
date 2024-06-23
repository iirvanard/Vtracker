import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vtracker/core/exception.dart';

class HttpClient {
  final _dio = Dio();

  Future<Response> get(String baseUrl,
      {dynamic headers, dynamic params}) async {
    try {
      var response =
          await _dio.get(baseUrl, data: headers, queryParameters: params);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioException catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }

  Future<Response> post(String baseUrl, {dynamic data, dynamic params}) async {
    try {
      var response =
          await _dio.post(baseUrl, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      print(e);
      throw ErrorHandler.handleError(e);
    }
  }

  Future<Response> put(String baseUrl, {dynamic data, dynamic params}) async {
    try {
      var response =
          await _dio.put(baseUrl, data: data, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }

  Future<Response> delete(String baseUrl,
      {dynamic data, dynamic params}) async {
    try {
      var response =
          await _dio.delete(baseUrl, data: data, queryParameters: params);

      return response;
    } on DioException catch (e) {
      throw ErrorHandler.handleError(e);
    }
  }
}
