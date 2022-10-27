class RequestConfirmPassword {
  String password;

  RequestConfirmPassword({
    required this.password,
  });

  Map<String, dynamic> toJson(RequestConfirmPassword request) {
    return {"password": password};
  }
}
