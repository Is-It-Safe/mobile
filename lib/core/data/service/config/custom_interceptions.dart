import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:is_it_safe_app/core/utils/helper/log.dart';

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

    Log.error("----------> INIT ERROR RESPONSE <----------");
    Log.error(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    Log.error("BODY => ${err.response?.data}");
    Log.error("-----> END ERROR RESPONSE <----------");
  }

  void _printRequest(RequestOptions options, {String? method, String? url}) {
    Log.request("----------> INIT APP REQUEST <----------");
    Log.request("${method ?? options.method} => ${url ?? options.path}");
    Log.request("HEADERS =>");
    options.headers.forEach((key, value) {
      Log.request("$key => $value");
    });
    Log.request("BODY => ${options.data}");
    Log.request("----------> END APP REQUEST <----------");
  }

  void _printResponse(Response response) {
    Log.response("----------> INIT API RESPONSE <----------");
    Log.response(response.requestOptions.path);
    Log.response("STATUS CODE => ${response.statusCode}");
    Log.response("HEADERS =>");
    response.headers.forEach((k, v) => Log.response('$k: $v'));
    Log.response("BODY => ${response.data}");
    Log.response("----------> END API RESPONSE <----------");

  }
}
