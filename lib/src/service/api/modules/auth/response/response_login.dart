class ResponseLogin {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  String? userFirstName;
  int? userId;
  String? userImage;

  ResponseLogin({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
    this.userFirstName,
    this.userId,
    this.userImage,
  });

  factory ResponseLogin.fromJson(dynamic json) {
    return ResponseLogin(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      refreshToken: json["refresh_token"],
      expiresIn: json["expires_in"],
      scope: json["scope"],
      userFirstName: json["userFirstName"],
      userId: json["userId"],
      userImage: json["profilePhoto"],
    );
  }
}
