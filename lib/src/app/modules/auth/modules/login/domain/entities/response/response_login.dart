class ResponseLogin {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  String? userFirstName;
  int? userId;
  String? userImage;

  ResponseLogin({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.userFirstName,
    this.userId,
    this.userImage,
  });

  factory ResponseLogin.fromJson(dynamic json) {
    return ResponseLogin(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      refreshToken: json["refresh_token"],
      userFirstName: json["userFirstName"],
      userId: json["userId"],
      userImage: json["profilePhoto"],
    );
  }
}
