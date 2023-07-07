import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/request/request_login.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_refresh_token.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/request/request_register.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_gender.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/response/response_login.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_refresh_token.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/response/response_register.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/response/response_sexual_orientation.dart';

abstract class IAuthService {
  Future<ResponseLogin> doLogin(RequestLogin request);
  Future<ResponseRefreshToken> doRefreshToken(RequestRefreshToken request);
  Future<ResponseRegister> doRegister(RequestRegister request);
  Future<List<ResponseGender>> getGenders();
  Future<List<ResponseSexualOrientation>> getSexualOrientations();
  Future<String> getAccessToken();
  Future<bool> confirmPassword(RequestConfirmPassword request);
  Future<bool> changePassword(String password);
  Future<bool> isUsernameAvailable(String username);
  Future<bool> isEmailAvailable(String email);
}
