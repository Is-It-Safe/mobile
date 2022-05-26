import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class ErrorExceptions extends DioError {
  final String? _title;
  final String? _message;

  ErrorExceptions([
    this._title,
    this._message,
  ]) : super(requestOptions: RequestOptions(path: StringConstants.empty));

  @override
  String toString() {
    return '$_title: $_message';
  }
}
