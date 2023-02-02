import 'dart:convert';

import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

/// [RequestLogin] é uma classe que contém os dados necessários para fazer uma solicitação de login ao servidor
class RequestLogin {
  String email;
  String password;
  String grantType;
  RequestLogin({
    required this.email,
    required this.password,
    this.grantType = ApiConstants.kGrantTypePassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'password': password,
      'grant_type': grantType,
    };
  }

  factory RequestLogin.fromMap(Map<String, dynamic> map) {
    return RequestLogin(
      email: map['username'] ?? '',
      password: map['password'] ?? '',
      grantType: map['grant_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestLogin.fromJson(String source) =>
      RequestLogin.fromMap(json.decode(source));
}
