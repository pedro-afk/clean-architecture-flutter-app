import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handler(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.unauthorized.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.unauthorized:
            return DataSource.unauthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.unknown.getFailure();
        }
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.unknown:
        return DataSource.unknown.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
            ResponseCode.badRequest, ResponseMessage.badRequest.tr());
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden.tr());
      case DataSource.unauthorized:
        return Failure(
            ResponseCode.unauthorized, ResponseMessage.unauthorized.tr());
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound.tr());
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError.tr());
      case DataSource.connectionTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout.tr());
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel.tr());
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout.tr());
      case DataSource.sendTimeout:
        return Failure(
            ResponseCode.sendTimeout, ResponseMessage.sendTimeout.tr());
      case DataSource.cacheError:
        return Failure(
            ResponseCode.cacheError, ResponseMessage.cacheError.tr());
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection.tr());
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.defaultError.tr());
      default:
        return Failure(ResponseCode.unknown, ResponseMessage.defaultError.tr());
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  static const String success = AppStrings.success;
  static const String noContent = AppStrings.noContent;
  static const String badRequest = AppStrings.badRequestError;
  static const String forbidden = AppStrings.forbiddenError;
  static const String unauthorized = AppStrings.unauthorizedError;
  static const String notFound = AppStrings.notFoundError;
  static const String internalServerError = AppStrings.internalServerError;

  // local responses codes
  static const String defaultError = AppStrings.defaultError;
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.defaultError;
  static const String receiveTimeout = AppStrings.timeoutError;
  static const String sendTimeout = AppStrings.timeoutError;
  static const String cacheError = AppStrings.defaultError;
  static const String noInternetConnection = AppStrings.noInternetError;
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
