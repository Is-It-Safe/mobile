import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

abstract class SafeResponse<S> {
  void getResult({
    required Function(dynamic data, String message) onError,
    required Function(S data, String message) onSuccess,
  }) {}
}

class SafeResponseError<S> implements SafeResponse<S> {
  dynamic data;
  String message;

  SafeResponseError({
    this.data,
    required this.message,
  });

  @override
  void getResult({
    required Function(dynamic data, String message) onError,
    required Function(S data, String message) onSuccess,
  }) {
    onError(data, message);
  }
}

class SafeResponseSuccess<S> implements SafeResponse<S> {
  S data;
  String message;

  SafeResponseSuccess({
    required this.data,
    this.message = StringConstants.empty,
  });

  @override
  void getResult({
    required Function(dynamic data, String message) onError,
    required Function(S data, String message) onSuccess,
  }) {
    onSuccess(data, message);
  }
}
