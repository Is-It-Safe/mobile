import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_sexual_orientation.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_gender.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_confirm_password.dart';

class MockAuthService implements IAuthService {
  final Dio client;

  MockAuthService(this.client);

  @override
  Future<bool> confirmPassword(RequestConfirmPassword request) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseLogin> doLogin(RequestLogin request) async {
    request = RequestLogin(
      email: 'basic@gmail.com',
      password: '123456',
    );
    final requestConfig = RequestConfig(
      path: 'https://jsonplaceholder.typicode.com/do_login',
      method: HttpMethod.post,
      body: request.toMap(),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          ApiConstants.kContentType: 'application/x-www-form-urlencoded',
        },
      ),
    );
    if (kDebugMode) {
      print(ApiConstants.kBasicAuth);
      print(requestConfig.body);
    }
    final response = await client.post(requestConfig.path,
        data: requestConfig.body, options: requestConfig.options);
    if (kDebugMode) {
      print(response.data);
    }

    return ResponseLogin.fromJson(jsonDecode(response.data));
  }

  @override
  Future<ResponseRefreshToken> doRefreshToken(RequestRefreshToken request) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseRegister> doRegister(RequestRegister request) async {
    if (kDebugMode) {
      print(request.toJson());
    }
    final requestConfig = RequestConfig(
      path: 'https://jsonplaceholder.typicode.com/do_register',
      method: HttpMethod.post,
      body: request.toJson(),
    );

    final response = await client.post(requestConfig.path,
        data: requestConfig.body, options: requestConfig.options);

    if (kDebugMode) {
      print(response.data);
    }

    return ResponseRegister.fromJson(jsonDecode(response.data));
  }

  @override
  Future<String> getAccessToken() {
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseGender>> getGenders() {
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseSexualOrientation>> getSexualOrientations() {
    throw UnimplementedError();
  }

  @override
  ApiService get service => throw UnimplementedError();
}
