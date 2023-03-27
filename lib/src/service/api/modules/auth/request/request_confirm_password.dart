import 'dart:convert';

class RequestConfirmPassword {
  String password;

  RequestConfirmPassword({
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
    };
  }

  factory RequestConfirmPassword.fromMap(Map<String, dynamic> map) {
    return RequestConfirmPassword(
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestConfirmPassword.fromJson(String source) =>
      RequestConfirmPassword.fromMap(json.decode(source));
}
