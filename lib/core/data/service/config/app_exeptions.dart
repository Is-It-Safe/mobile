import 'package:dio/dio.dart';

class AppException extends DioError {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix])
      : super(
          requestOptions: RequestOptions(path: ""),
        );

  String toString() {
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? json]) : super(json, "");
}
