import 'dart:convert';
import 'dart:io';
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
}
