// ignore_for_file: file_names

class Auth {
  Auth({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.scope,
    required this.userFirstName,
    required this.userId,
  });
  late final String accessToken;
  late final String tokenType;
  late final String refreshToken;
  late final int expiresIn;
  late final String scope;
  late final String userFirstName;
  late final int userId;

  Auth.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    userFirstName = json['userFirstName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['access_token'] = accessToken;
    _data['token_type'] = tokenType;
    _data['refresh_token'] = refreshToken;
    _data['expires_in'] = expiresIn;
    _data['scope'] = scope;
    _data['userFirstName'] = userFirstName;
    _data['userId'] = userId;
    return _data;
  }
}
