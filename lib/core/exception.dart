import 'package:dio/dio.dart';
import 'package:vtracker/core/failure.dart';

class ErrorHandler implements Exception {
  static Failure handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return const ServerFailure("connection Error");
      case DioExceptionType.connectionTimeout:
        return ConnectionFailure(error.response.toString());
      case DioExceptionType.sendTimeout:
        return ConnectionFailure(error.response.toString());
      case DioExceptionType.receiveTimeout:
        return ConnectionFailure(error.response.toString());
      case DioExceptionType.badResponse:
        return handleErrorStatus(error);
      case DioExceptionType.cancel:
        return ConnectionFailure(error.response.toString());
      case DioExceptionType.unknown:
        return const ConnectionFailure("unknown error");

      default:
        return const ConnectionFailure("unknown error");
    }
  }

  static Failure handleErrorStatus(DioException error) {
    switch (error.response!.statusCode) {
      case 400:
        return ServerFailure(error.response.toString());
      default:
        return ServerFailure(error.response.toString());
    }
  }
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
