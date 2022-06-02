import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_gender.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_sexual_orientation.dart';

class AuthService implements IAuthService {
  final ApiService _service = ApiService();
  @override
  Future<ResponseLogin> doLogin(RequestLogin request) async {
    request = RequestLogin(
      email: 'cvpinhofsa@gmail.com',
      password: '123456',
    );
    final requestConfig = RequestConfig(
      path: ApiConstants.doAuth,
      method: HttpMethod.post,
      body: request.toJson(request),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          ApiConstants.kContentType: 'application/x-www-form-urlencoded',
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseLogin.fromJson(jsonDecode(response.data));
  }

  @override
  Future<ResponseRefreshToken> doRefreshToken(
    RequestRefreshToken request,
  ) async {
    final requestConfig = RequestConfig(
      path: ApiConstants.doAuth,
      method: HttpMethod.post,
      body: request.toJson(request),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          ApiConstants.kContentType: 'application/x-www-form-urlencoded',
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseRefreshToken.fromJson(jsonDecode(response.data));
  }

  @override
  Future<ResponseRegister> doRegister(RequestRegister request) async {
    final requestConfig = RequestConfig(
      path: ApiConstants.doRegister,
      method: HttpMethod.post,
      body: request.toJson(request),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseRegister.fromJson(jsonDecode(response.data));
  }

  @override
  Future<List<ResponseGender>> getGenders() async {
    final requestConfig = RequestConfig(
      path: ApiConstants.getGenders,
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGender.fromJson(e))
        .toList();
  }

  @override
  Future<List<ResponseSexualOrientation>> getSexualOrientations() async {
    final requestConfig = RequestConfig(
      path: ApiConstants.getSexualOrientations,
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseSexualOrientation.fromJson(e))
        .toList();
  }
}
