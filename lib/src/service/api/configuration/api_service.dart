import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/error/error_fetch_data_exception.dart';
import 'package:is_it_safe_app/src/service/api/error/error_messages.dart';

///A classe [APIService] é responsável por administrar as requisições realizadas na API
class ApiService implements IApiService {
  final Dio _dio = Dio();
  final Duration _timeout = const Duration(seconds: 60);

  ApiService() {
    _dio.interceptors.add(ApiInterceptors());
    _dio.options.responseType = ResponseType.plain;
  }

  /// Recebe um objeto RequestConfig e, com base no método, chama a função apropriada
  ///
  /// Args:
  /// ```RequestConfig config```: Este é o objeto [RequestConfig] que contém todas as informações sobre
  /// o pedido.
  ///
  /// Retorna:
  /// Um ```Future<Response>```
  @override
  Future<Response> doRequest(RequestConfig config) async {
    Response response;
    try {
      switch (config.method) {
        case HttpMethod.post:
          response = await post(config);
          break;
        case HttpMethod.get:
          response = await get(config);
          break;
        case HttpMethod.patch:
          response = await patch(config);
          break;
        case HttpMethod.delete:
          response = await delete(config);
          break;
      }
      return response;
    } on SocketException {
      throw FetchDataException(ErrorMessages.errorNoInternetConnection);
    }
  }

  @override
  Future<Response> post(RequestConfig config) async {
    final _response = await _dio
        .post(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(_response);
  }

  @override
  Future<Response> get(RequestConfig config) async {
    final _response = await _dio
        .get(
          config.path,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(_response);
  }

  @override
  Future<Response> patch(RequestConfig config) async {
    final _response = await _dio
        .patch(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(_response);
  }

  @override
  Future<Response> delete(RequestConfig config) async {
    final _response = await _dio
        .delete(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(_response);
  }

  @override
  Response getResponse(Response response) {
    final isSuccess = response.statusCode! >= 200 && response.statusCode! < 300;

    if (isSuccess) {
      try {
        return json.decode(response.data.toString());
      } catch (e) {
        LogUtil().response(e.toString(), isError: true);
        throw FetchDataException(response.data.toString());
      }
    } else {
      LogUtil().response(response.data.toString(), isError: true);
      throw FetchDataException(response.data.toString());
    }
  }
}
