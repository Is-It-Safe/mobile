import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class RequestCanceledException extends DioException {
  RequestCanceledException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was cancelled.';
  }
}

class ConnectTimeoutException extends DioException {
  ConnectTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was taking too long.';
  }
}

class RecieveTimeoutException extends DioException {
  RecieveTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The response was taking too long.';
  }
}

class RequestTimeoutException extends DioException {
  RequestTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The request was taking too long.';
  }
}

class ServiceUnavailableException extends DioException {
  ServiceUnavailableException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The service is unavailable.';
  }
}

class DefaultNetworkException extends DioException {
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

class SendTimeoutException extends DioException {
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
