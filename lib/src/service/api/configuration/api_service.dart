import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/error/safe_exceptions.dart';

///A classe [APIService] é responsável por administrar as requisições realizadas na API
class ApiService implements IApiService {
  final Dio dio = createDio();
  ApiService._internal();
  static final _singleton = ApiService._internal();
  factory ApiService() => _singleton;

  static const _timeout = Duration(minutes: 2);

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        receiveTimeout: _timeout.inMilliseconds,
        connectTimeout: _timeout.inMilliseconds,
        sendTimeout: _timeout.inMilliseconds,
        responseType: ResponseType.plain,
      ),
    );
    dio.interceptors.addAll({ApiInterceptors()});
    return dio;
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
        case HttpMethod.put:
          response = await put(config);
          break;
      }
      return response;
    } catch (e) {
      throw SafeExeptions.onError(e);
    }
  }

  @override
  Future<Response> post(RequestConfig config) async {
    final response = await dio
        .post(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(response);
  }

  @override
  Future<Response> get(RequestConfig config) async {
    final response = await dio
        .get(
          config.path,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(response);
  }

  @override
  Future<Response> patch(RequestConfig config) async {
    final response = await dio
        .patch(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(response);
  }

  @override
  Future<Response> put(RequestConfig config) async {
    final response = await dio
        .put(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(response);
  }

  @override
  Future<Response> delete(RequestConfig config) async {
    final response = await dio
        .delete(
          config.path,
          data: config.body,
          options: config.options,
          queryParameters: config.parameters,
        )
        .timeout(_timeout);
    return getResponse(response);
  }

  @override
  Response getResponse(Response response) {
    final isSuccess = response.statusCode! >= 200 && response.statusCode! < 300;

    if (isSuccess) {
      try {
        return response;
      } catch (e) {
        throw SafeExeptions.onError(e);
      }
    } else {
      throw SafeExeptions.onError(response.data.toString());
    }
  }
}
