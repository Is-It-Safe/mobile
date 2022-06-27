class ResponseRefreshToken {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  String? userFirstName;
  int? userId;

  ResponseRefreshToken({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.userFirstName,
    this.userId,
  });

  factory ResponseRefreshToken.fromJson(dynamic json) {
    return ResponseRefreshToken(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      refreshToken: json["refresh_token"],
      expiresIn: json["expires_in"],
      scope: json["scope"],
      userFirstName: json["user_first_name"],
      userId: json["user_id"],
    );
  }
}
