import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomInterceptors extends InterceptorsWrapper {
  Dio _dio;

  CustomInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler interceptorHandler) async {
    if (kDebugMode) {
      _printRequest(options);
    }
    return super.onRequest(options, interceptorHandler);
  }

  @override
  Future onResponse(Response response,
      ResponseInterceptorHandler responseInterceptorHandler) async {
    if (kDebugMode) {
      _printResponse(response);
    }
    return super.onResponse(response, responseInterceptorHandler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler errorInterceptorHandler) {
    if (kDebugMode) {
      _printError(err);
    }
    return super.onError(err, errorInterceptorHandler);
  }

  void _printError(DioError err) {
    print("----------> INIT ERROR RESPONSE <----------");
    print(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    print("BODY => ${err.response?.data}");
    print("-----> END ERROR RESPONSE <----------");
  }

  void _printRequest(RequestOptions options, {String? method, String? url}) {
    print("----------> INIT APP REQUEST <----------");
    print(
        "${method != null ? method : options.method} => ${url != null ? url : options.path}");
    print("HEADERS =>");
    options.headers.forEach((key, value) {
      print("$key => $value");
    });
    print("BODY => ${options.data}");
    print("----------> END APP REQUEST <----------");
  }

  void _printResponse(Response response) {
    print("----------> INIT API RESPONSE <----------");
    print("${response.requestOptions.path}");
    print("STATUS CODE => ${response.statusCode}");
    print("HEADERS =>");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("BODY => ${response.data}");
    print("----------> END API RESPONSE <----------");
  }
}
