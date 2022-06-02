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
      path: err.requestOptions.path,
      statusCode: err.response?.statusCode,
      header: err.requestOptions.headers.toString(),
      params: err.requestOptions.data.toString(),
      body: err.response?.data,
      isError: true,
    );
  }

  void _logRequest(RequestOptions options) {
    LogUtil().request(
      path: options.path,
      header: options.headers.toString(),
      body: options.data.toString(),
      http: options.method,
    );
  }

  void _logResponse(Response response) {
    LogUtil().response(
      path: response.requestOptions.path,
      statusCode: response.statusCode,
      header: response.headers.toString(),
      params: response.requestOptions.data.toString(),
      body: response.data,
    );
  }
}
