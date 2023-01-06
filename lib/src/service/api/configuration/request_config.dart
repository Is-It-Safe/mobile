import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';

///A classe [RequestConfig] é responsável por armazenar as configurações de requisição
class RequestConfig {
  final String path;
  final HttpMethod method;
  final dynamic body;
  final Map<String, dynamic>? parameters;
  final Options? options;

  RequestConfig({
    required this.path,
    required this.method,
    this.options,
    this.body,
    this.parameters,
  });
}
