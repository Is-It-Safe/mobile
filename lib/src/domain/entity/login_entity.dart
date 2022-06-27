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
}
