import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

/// [RequestLogin] é uma classe que contém os dados necessários para fazer uma solicitação de login ao servidor
class RequestLogin {
  String username;
  String password;
  String grantType;
  RequestLogin({
    required this.username,
    required this.password,
    this.grantType = ApiConstants.kGrantTypePassword,
  });

  FormData toJson(RequestLogin request) {
    return FormData.fromMap(
      {
        'username': request.username,
        'password': request.password,
        'grant_type': request.grantType,
      },
    );
  }
}
