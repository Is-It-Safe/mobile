import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/response/response_login.dart';

import '../../core/constants/int_constants.dart';
import '../../core/constants/string_constants.dart';

class LoginEntity {
  String accessToken;
  String tokenType;
  String refreshToken;
  String userFirstName;
  int userId;
  String userImage;

  LoginEntity({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.userFirstName,
    required this.userId,
    required this.userImage,
  });

  factory LoginEntity.toEntity(ResponseLogin response) {
    return LoginEntity(
      accessToken: response.accessToken ?? StringConstants.empty,
      tokenType: response.tokenType ?? StringConstants.empty,
      refreshToken: response.refreshToken ?? StringConstants.empty,
      userFirstName: response.userFirstName ?? StringConstants.empty,
      userId: response.userId ?? IntConstants.empty,
      userImage: response.userImage ?? StringConstants.empty,
    );
  }
}
