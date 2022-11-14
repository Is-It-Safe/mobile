import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';

abstract class IApiService {
  Future<Response> doRequest(RequestConfig config);
  Future<Response> post(RequestConfig config);
  Future<Response> get(RequestConfig config);
  Future<Response> patch(RequestConfig config);
  Future<Response> put(RequestConfig config);
  Future<Response> delete(RequestConfig config);
  Response getResponse(Response response);
}
