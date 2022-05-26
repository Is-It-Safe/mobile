import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

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
    LogUtil().response(
      "----------> INIT ERROR RESPONSE <----------",
      isError: true,
    );
    LogUtil().response(
      "ERROR[${err.response?.statusCode}]: PATH: ${err.requestOptions.path}",
      isError: true,
    );
    LogUtil().response(
      "BODY: ${err.response?.data}",
      isError: true,
    );
    LogUtil().response(
      "-----> END ERROR RESPONSE <----------",
      isError: true,
    );
  }

  void _printRequest(RequestOptions options, {String? method, String? url}) {
    LogUtil().request("----------> INIT APP REQUEST <----------");
    LogUtil().request("${method ?? options.method}: ${url ?? options.path}");
    options.headers.forEach((key, value) {
      LogUtil().request("HEADERS: $key => $value");
    });
    LogUtil().request("BODY: ${options.data}");
    LogUtil().request("----------> END APP REQUEST <----------");
  }

  void _printResponse(Response response) {
    LogUtil().response("----------> INIT API RESPONSE <----------");
    LogUtil().response(response.requestOptions.path);
    LogUtil().response("STATUS CODE: ${response.statusCode}");
    response.headers.forEach((k, v) => LogUtil().response('HEADERS: $k: $v'));
    LogUtil().response("BODY: ${response.data}");
    LogUtil().response("----------> END API RESPONSE <----------");
  }
}
