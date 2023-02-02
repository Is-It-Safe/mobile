import 'dart:convert';

import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

class RequestRefreshToken {
  String refreshToken;
  String grantType;
  RequestRefreshToken({
    required this.refreshToken,
    this.grantType = ApiConstants.kGrantTypeRefreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'refresh_token': refreshToken,
      'grant_type': grantType,
    };
  }

  factory RequestRefreshToken.fromMap(Map<String, dynamic> map) {
    return RequestRefreshToken(
      refreshToken: map['refresh_token'] ?? '',
      grantType: map['grant_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestRefreshToken.fromJson(String source) =>
      RequestRefreshToken.fromMap(json.decode(source));
}
