import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';
import 'package:is_it_safe_app/src/service/api/error/safe_exceptions.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_gender.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_refresh_token.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_sexual_orientation.dart';

import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService implements IAuthService {
  final ApiService service;

  AuthService(this.service);

  @override
  Future<ResponseLogin> doLogin(RequestLogin request) async {
    try {
      assert(request.email.isNotEmpty, "Campo e-mail não pode estar vazio!");
      assert(request.password.isNotEmpty, "Campo e-mail não pode estar vazio!");

      request = RequestLogin(
        email: request.email,
        password: request.password,
      );
      final requestConfig = RequestConfig(
        path: ApiConstants.doAuth,
        method: HttpMethod.post,
        body: request.toJson(request),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
            ApiConstants.kContentType: 'application/x-www-form-urlencoded',
          },
        ),
      );

      final response = await service.doRequest(requestConfig);

      return ResponseLogin.fromJson(jsonDecode(response.data));
    } on DioError catch (error) {
      throw SafeDioResponseError(error.message);
    } on AssertionError catch (e) {
      throw SafeInvalidCredentialsError(e.message.toString());
    }
  }

  @override
  Future<String> getAccessToken() async {
    String token = await SharedPreferencesService().readToken();
    DateTime expirationDate = Jwt.getExpiryDate(token) ?? DateTime.now();
    int expirationDifference =
        DateTime.now().difference(expirationDate).inMinutes;
    if (expirationDifference < 5) {
      String refreshToken = await SharedPreferencesService().readRefreshToken();
      final request = RequestRefreshToken(refreshToken: refreshToken);

      await doRefreshToken(request).then((response) {
        token = response.accessToken ?? StringConstants.empty;
        refreshToken = response.refreshToken ?? StringConstants.empty;
        SharedPreferencesService().saveToken(token);
        SharedPreferencesService().saveRefreshToken(refreshToken);
      }).catchError((e, s) {
        SafeLogUtil.instance.logError(e);
        throw GetTokenException();
      }).whenComplete(() => 'Bearer $token');
    }
    return 'Bearer $token';
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
      body: request.toJson(request),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          ApiConstants.kContentType: 'application/x-www-form-urlencoded',
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
}
