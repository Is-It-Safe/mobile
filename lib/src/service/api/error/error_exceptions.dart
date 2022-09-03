import 'package:dio/dio.dart';

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class RequestCanceledException extends DioError {
  RequestCanceledException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was cancelled.';
  }
}

class ConnectTimeoutException extends DioError {
  ConnectTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was taking too long.';
  }
}

class RecieveTimeoutException extends DioError {
  RecieveTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The response was taking too long.';
  }
}

class RequestTimeoutException extends DioError {
  RequestTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was taking too long.';
  }
}

class ServiceUnavailableException extends DioError {
  ServiceUnavailableException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The service is unavailable.';
  }
}

class DefaultNetworkException extends DioError {
  final int statusCode;
  DefaultNetworkException({
    required RequestOptions r,
    required this.statusCode,
  }) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid status code: $statusCode';
  }
}

class SendTimeoutException extends DioError {
  SendTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was taking to long.';
  }
}

class SafeFormatException extends FormatException {
  SafeFormatException() : super();

  @override
  String toString() {
    return 'A FormatException has occurred.';
  }
}

class UnableToProcessException implements Exception {
  final String error;
  UnableToProcessException(this.error) : super();

  @override
  String toString() {
    return 'The action were unable to be processed: $error';
  }
}

class DefaultException implements Exception {
  final String error;
  DefaultException(this.error) : super();

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.\n$error';
  }
}

class GetTokenException implements Exception {
  GetTokenException() : super();

  @override
  String toString() {
    return 'Your token expired, please login again.';
  }
}
