import 'dart:convert';

/// [RequestLogin] é uma classe que contém os dados necessários para fazer uma solicitação de login ao servidor
class RequestLogin {
  final String email;
  final String password;
  RequestLogin({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': 'admin@gmail.com',
      'password': '123456',
    };
  }

  String toJson() => json.encode(toMap());
}
