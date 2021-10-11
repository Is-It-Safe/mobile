import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/core/data/service/config/api_constants.dart';

import 'app_exeptions.dart';
import 'custom_interceptions.dart';

enum HttpMethod { get, post, patch, delete }

class RequestConfig {
  final String path;
  final HttpMethod method;
  final dynamic body;
  final dynamic parameters;

  RequestConfig(
    this.path,
    this.method, {
    this.body,
    this.parameters,
  });
}

class APIService {
  Dio dio = Dio();

  final Duration _timeout = const Duration(seconds: 60);

  APIService() {
    dio.interceptors.add(CustomInterceptors(dio));
  }

  Future doRequest(RequestConfig config) async {
    String url = ApiConstants.kBaseUrl;
    Options options = ApiConstants.kOptions;
    Map<String, dynamic> queryParameters = ApiConstants.kqueryParameters;

    if (!config.path.contains("http")) {
      url += config.path;
    } else {
      url = config.path;
    }

    var responseJson;

    try {
      switch (config.method) {
        case HttpMethod.get:
          final response = await dio
              .get(
                url,
                options: options,
                queryParameters: queryParameters,
              )
              .timeout(_timeout);
          responseJson = _returnResponse(response);
          break;
        case HttpMethod.post:
          var body;
          if (config.body is FormData) {
            body = config.body;
          } else {
            body = jsonEncode(config.body);
          }
          final response = await dio
              .post(
                url,
                data: body,
                options: options,
                queryParameters: queryParameters,
              )
              .timeout(_timeout);
          responseJson = _returnResponse(response);
          break;
        case HttpMethod.patch:
          var body;
          if (config.body is FormData) {
            body = config.body;
          } else {
            body = jsonEncode(config.body);
          }
          final response = await dio
              .patch(
                url,
                data: body,
                options: options,
                queryParameters: queryParameters,
              )
              .timeout(_timeout);
          responseJson = _returnResponse(response);
          break;
        case HttpMethod.delete:
          final response = await dio
              .delete(
                url,
                options: options,
                queryParameters: queryParameters,
              )
              .timeout(_timeout);
          responseJson = _returnResponse(response);
          break;
      }
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }

  _returnResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      try {
        var result = json.decode(response.data.toString());
        return result;
      } catch (e) {
        try {
          return response.data;
        } catch (e) {
          try {
            return (response.data as List?);
          } catch (e) {
            print(e.toString());
            return Map<String, dynamic>();
          }
        }
      }
    } else {
      return response.data;
    }
  }
}
