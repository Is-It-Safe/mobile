import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/request/request_login.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_refresh_token.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/request/request_register.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_gender.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/response/response_login.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_refresh_token.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/response/response_register.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_sexual_orientation.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service_interface.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_interceptors.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService implements IAuthService {
  final ApiService service;

  AuthService(this.service);

  @override
  Future<ResponseLogin> doLogin(RequestLogin request) async {
    try {
      request = RequestLogin(
        email: request.email,
        password: request.password,
      );
      final requestConfig = RequestConfig(
        path: ApiConstants.doAuth,
        method: HttpMethod.post,
        body: request.toMap(),
        options: Options(
          headers: {
            ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          },
        ),
      );

      final response = await service.doRequest(requestConfig);

      return ResponseLogin.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      throw SafeDioResponseError(e.message);
    }
  }

  @override
  Future<String> getAccessToken() async {
    DateTime now = DateTime.now();
    String accessToken = await SharedPreferencesService().readToken();
    DateTime accessTokenExpiration = Jwt.getExpiryDate(accessToken) ?? now;
    String refreshToken = await SharedPreferencesService().readRefreshToken();
    DateTime refreshTokenExpiration = Jwt.getExpiryDate(refreshToken) ?? now;

    if (accessTokenExpiration.isAfter(now)) {
      return 'Bearer $accessToken';
    } else if (refreshTokenExpiration.isAfter(now)) {
      return 'Bearer $refreshToken';
    } else {
      await ApiInterceptors.doLogout();
    }
    return 'Bearer $refreshToken';
  }

  @override
  Future<ResponseRefreshToken> doRefreshToken(
    RequestRefreshToken request,
  ) async {
    final requestConfig = RequestConfig(
      path: ApiConstants.doRefresh,
      method: HttpMethod.post,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: 'Bearer ${request.refreshToken}',
        },
      ),
    );

    final response = await service.doRequest(requestConfig);

    return ResponseRefreshToken.fromJson(jsonDecode(response.data));
  }

  @override
  Future<bool> confirmPassword(
    RequestConfirmPassword request,
  ) async {
    final requestConfig = RequestConfig(
      path: ApiConstants.confirmPassword,
      method: HttpMethod.post,
      body: request.toJson(),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
        },
      ),
    );

    final response = await service.doRequest(requestConfig);

    return jsonDecode(response.data);
  }

  @override
  Future<ResponseRegister> doRegister(RequestRegister request) async {
    try {
      final requestConfig = RequestConfig(
        path: ApiConstants.doRegister,
        method: HttpMethod.post,
        body: request.toJson(),
      );

      final response = await service.doRequest(requestConfig);

      return ResponseRegister.fromJson(jsonDecode(response.data));
    } on DioError catch (e) {
      // TODO Refatorar código
      if (e.message == StringConstants.empty) {
        throw SafeDioResponseError(
          'Erro ao realizar o cadastro. Tente novamente mais tarde.',
        );
      }
      throw SafeDioResponseError(e.message);
    }
  }

  @override
  Future<List<ResponseGender>> getGenders() async {
    try {
      final requestConfig = RequestConfig(
        path: ApiConstants.getGenders,
        method: HttpMethod.get,
      );

      final response = await service.doRequest(requestConfig);
      return (json.decode(response.data) as List)
          .map((e) => ResponseGender.fromJson(e))
          .toList();
    } on DioError catch (error) {
      throw SafeDioResponseError(error.message);
    }
  }

  @override
  Future<List<ResponseSexualOrientation>> getSexualOrientations() async {
    try {
      final requestConfig = RequestConfig(
        path: ApiConstants.getSexualOrientations,
        method: HttpMethod.get,
      );

      final response = await service.doRequest(requestConfig);
      return (json.decode(response.data) as List)
          .map((e) => ResponseSexualOrientation.fromJson(e))
          .toList();
    } on DioError catch (e) {
      throw SafeDioResponseError(e.message);
    }
  }

  @override
  Future<bool> changePassword(String password) async {
    // TODO: Implementar endpoint quando estiver pronto
    throw UnimplementedError();
  }
}
