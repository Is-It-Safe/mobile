import 'dart:convert';

import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

/// [RequestLogin] é uma classe que contém os dados necessários para fazer uma solicitação de login ao servidor
class RequestLogin {
  final String email;
  final String password;
  final String grantType;
  RequestLogin({
    required this.email,
    required this.password,
    this.grantType = ApiConstants.kGrantTypePassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'password': password,
      'grant_type': ApiConstants.kGrantTypePassword,
    };
  }

  String toJson() => json.encode(toMap());
}
