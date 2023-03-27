class RequestRefreshToken {
  String refreshToken;
  RequestRefreshToken({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson(RequestRefreshToken request) {
    return {
      'refresh_token': request.refreshToken,
    };
  }
}
