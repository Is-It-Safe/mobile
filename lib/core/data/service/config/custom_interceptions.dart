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
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}",
        name: "RESPONSE ERROR");
    dev.log("BODY => ${err.response?.data}", name: "RESPONSE ERROR");
    dev.log("-----> END ERROR RESPONSE <----------", name: "RESPONSE ERROR");
  }

  void _printRequest(RequestOptions options, {String? method, String? url}) {
    dev.log("----------> INIT APP REQUEST <----------", name: "APP REQUEST");
    dev.log("${method ?? options.method} => ${url ?? options.path}",
        name: "APP REQUEST");
    dev.log("HEADERS =>", name: "APP REQUEST");
    options.headers.forEach((key, value) {
      dev.log("$key => $value", name: "APP REQUEST");
    });
    dev.log("BODY => ${options.data}", name: "APP REQUEST");
    dev.log("----------> END APP REQUEST <----------", name: "APP REQUEST");
  }

  void _printResponse(Response response) {
    dev.log("----------> INIT API RESPONSE <----------", name: "API RESPONSE");
    dev.log(response.requestOptions.path, name: "API RESPONSE");
    dev.log("STATUS CODE => ${response.statusCode}", name: "API RESPONSE");
    dev.log("HEADERS =>", name: "API RESPONSE");
    response.headers.forEach((k, v) => dev.log('$k: $v'));
    dev.log("BODY => ${response.data}", name: "API RESPONSE");
    dev.log("----------> END API RESPONSE <----------", name: "API RESPONSE");
  }
}
