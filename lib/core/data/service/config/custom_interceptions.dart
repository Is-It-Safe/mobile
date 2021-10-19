import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dart:developer' as dev;

class CustomInterceptors extends InterceptorsWrapper {
  // ignore: unused_field
  final Dio _dio;

  CustomInterceptors(this._dio);

  @override
  Future onRequest(
      RequestOptions options,
      // ignore: avoid_renaming_method_parameters
      RequestInterceptorHandler interceptorHandler) async {
    if (kDebugMode) {
      _printRequest(options);
    }
    return super.onRequest(options, interceptorHandler);
  }

  @override
  Future onResponse(
      Response response,
      // ignore: avoid_renaming_method_parameters
      ResponseInterceptorHandler responseInterceptorHandler) async {
    if (kDebugMode) {
      _printResponse(response);
    }
    return super.onResponse(response, responseInterceptorHandler);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  onError(DioError err, ErrorInterceptorHandler errorInterceptorHandler) {
    if (kDebugMode) {
      _printError(err);
    }
    return super.onError(err, errorInterceptorHandler);
  }

  void _printError(DioError err) {
    dev.log("----------> INIT ERROR RESPONSE <----------",
        name: "RESPONSE ERROR");
    dev.log(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    dev.log("BODY => ${err.response?.data}");
    dev.log("-----> END ERROR RESPONSE <----------");
  }

  void _printRequest(RequestOptions options, {String? method, String? url}) {
    dev.log("----------> INIT APP REQUEST <----------");
    dev.log("${method ?? options.method} => ${url ?? options.path}");
    dev.log("HEADERS =>");
    options.headers.forEach((key, value) {
      dev.log("$key => $value");
    });
    dev.log("BODY => ${options.data}");
    dev.log("----------> END APP REQUEST <----------");
  }

  void _printResponse(Response response) {
    dev.log("----------> INIT API RESPONSE <----------");
    dev.log(response.requestOptions.path);
    dev.log("STATUS CODE => ${response.statusCode}");
    dev.log("HEADERS =>");
    response.headers.forEach((k, v) => dev.log('$k: $v'));
    dev.log("BODY => ${response.data}");
    dev.log("----------> END API RESPONSE <----------");
  }
}
