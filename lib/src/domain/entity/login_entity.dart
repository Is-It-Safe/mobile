import '../../core/constants/int_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../service/api/modules/auth/response/response_login.dart';

class LoginEntity {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String userFirstName;
  int userId;

  LoginEntity({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.scope,
    required this.userFirstName,
    required this.userId,
  });

  factory LoginEntity.toEntity(ResponseLogin response) {
    return LoginEntity(
      accessToken: response.accessToken ?? StringConstants.empty,
      tokenType: response.tokenType ?? StringConstants.empty,
      refreshToken: response.refreshToken ?? StringConstants.empty,
      expiresIn: response.expiresIn ?? IntConstants.empty,
      scope: response.scope ?? StringConstants.empty,
      userFirstName: response.userFirstName ?? StringConstants.empty,
      userId: response.userId ?? IntConstants.empty,
    );
  }
}
