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

  Map<String, dynamic> toJson(RequestLogin request) {
    return {
      'username': request.email,
      'password': request.password,
      'grant_type': ApiConstants.kGrantTypePassword,
    };
  }
}
