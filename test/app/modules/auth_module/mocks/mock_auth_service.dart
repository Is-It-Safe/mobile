import 'dart:convert';
import 'dart:io';
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

class MockAuthService implements IAuthService {
  @override
  Future<bool> confirmPassword(RequestConfirmPassword request) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseLogin> doLogin(RequestLogin request) async {
    return ResponseLogin.fromJson(jsonDecode(
        File("test/app/modules/auth_module/login_response.json")
            .readAsStringSync()));
  }

  @override
  Future<ResponseRefreshToken> doRefreshToken(RequestRefreshToken request) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseRegister> doRegister(RequestRegister request) async {
    return ResponseRegister.fromJson(jsonDecode(
        File("test/app/modules/auth_module/register_response.json")
            .readAsStringSync()));
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
  Future<bool> changePassword(String password) {
    throw UnimplementedError();
  }
}
