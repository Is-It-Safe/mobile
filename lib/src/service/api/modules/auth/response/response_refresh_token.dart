class ResponseRefreshToken {
  String? tokenType;
  String? refreshToken;

  ResponseRefreshToken({
    this.tokenType,
    this.refreshToken,
  });

  factory ResponseRefreshToken.fromJson(dynamic json) {
    return ResponseRefreshToken(
      tokenType: json["token_type"],
      refreshToken: json["refresh_token"],
    );
  }
}
