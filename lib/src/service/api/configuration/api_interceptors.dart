import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

///A classe [ApiInterceptors] é responsável por gerenciar as intercepções da API
class ApiInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (kDebugMode) _logRequest(options);
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (kDebugMode) _logResponse(response);
    return super.onResponse(response, handler);
  }

  @override
  onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (kDebugMode) _logError(err);
    return super.onError(err, handler);
  }

  void _logError(DioError err) {
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

  void _logRequest(
    RequestOptions options, {
    String? method,
    String? url,
  }) {
    LogUtil().request("----------> INIT APP REQUEST <----------");
    LogUtil().request("${method ?? options.method}: ${url ?? options.path}");
    options.headers.forEach((key, value) {
      LogUtil().request("HEADERS: $key => $value");
    });
    LogUtil().request("BODY: ${options.data}");
    LogUtil().request("----------> END APP REQUEST <----------");
  }

  void _logResponse(Response response) {
    LogUtil().response("----------> INIT API RESPONSE <----------");
    LogUtil().response(response.requestOptions.path);
    LogUtil().response("STATUS CODE: ${response.statusCode}");
    response.headers.forEach((k, v) => LogUtil().response('HEADERS: $k: $v'));
    LogUtil().response("BODY: ${response.data}");
    LogUtil().response("----------> END API RESPONSE <----------");
  }
}
