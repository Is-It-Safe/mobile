import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class SafeExeptions {
  static Exception onError(dynamic error) {
    Exception exception = DefaultException(error.toString());
    if (error is Exception) {
      try {
        if (error is DioError) exception = _handleDioError(error);
      } on FormatException {
        exception = SafeFormatException();
      } catch (_) {
        throw exception;
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        exception = UnableToProcessException(error);
      }
    }
    throw exception;
  }

  static Exception _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return RequestCanceledException(error.requestOptions);
      case DioErrorType.connectTimeout:
        return ConnectTimeoutException(error.requestOptions);
      case DioErrorType.receiveTimeout:
        return RecieveTimeoutException(error.requestOptions);
      case DioErrorType.sendTimeout:
        return SendTimeoutException(error.requestOptions);
      case DioErrorType.other:
        return InternalServerErrorException(error.requestOptions);
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case 400:
            return UnauthorizedException(error.requestOptions);
          case 401:
            return UnauthorizedException(error.requestOptions);
          case 403:
            return UnauthorizedException(error.requestOptions);
          case 404:
            return NotFoundException(error.requestOptions);
          case 409:
            return ConflictException(error.requestOptions);
          case 408:
            return RequestTimeoutException(error.requestOptions);
          case 500:
            return InternalServerErrorException(error.requestOptions);
          case 503:
            return ServiceUnavailableException(error.requestOptions);
          default:
            var responseCode = error.response?.statusCode;
            if (responseCode != null) {
              return DefaultNetworkException(
                r: error.requestOptions,
                statusCode: responseCode,
              );
            } else {
              return InternalServerErrorException(error.requestOptions);
            }
        }
      default:
        return InternalServerErrorException(error.requestOptions);
    }
  }
}
