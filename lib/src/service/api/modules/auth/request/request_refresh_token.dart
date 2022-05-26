import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

class RequestRefreshToken {
  String refreshToken;
  String grantType;
  RequestRefreshToken({
    required this.refreshToken,
    this.grantType = ApiConstants.kGrantTypeRefreshToken,
  });

  FormData toJson(RequestRefreshToken request) {
    return FormData.fromMap(
      {
        'refresh_token': request.refreshToken,
        'grant_type': request.grantType,
      },
    );
  }
}
