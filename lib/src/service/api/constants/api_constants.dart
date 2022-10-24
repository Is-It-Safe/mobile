import 'dart:convert';

/// [ApiConstants] é uma classe que contém todas as constantes usadas nas requisições da API
class ApiConstants {
  ///Credenciais de autenticação
  static const String kClientCredentials = 'isitsafe:isitsafe123';
  static const String kAuthorization = 'Authorization';
  static const String kContentType = 'Content-Type';

  ///Base64 de credenciais de autenticação
  static String kEncodedClientCredentials = base64Encode(
    utf8.encode(kClientCredentials),
  );

  ///Grant Type
  static const String kGrantTypePassword = 'password';
  static const String kGrantTypeRefreshToken = 'refresh_token';

  ///Basic Auth para autenticação do Login
  static String kBasicAuth = 'Basic $kEncodedClientCredentials';

  ///URL para requisições de autenticação
  static const String kAuthUrl = 'https://is-it-safe-api-v2.herokuapp.com/';

  ///Url default para requisições da API
  static const String kUrl =
      'https://is-it-safe-api-v2.herokuapp.com/is-it-safe/';

  /*--------------------------------------------------------------------*/

  //Auth
  static const String doAuth = '${kAuthUrl}oauth/token';
  static const String doRegister = '${kUrl}user/save';
  static const String getGenders = '${kUrl}gender/find-all';
  static const String getSexualOrientations = '${kUrl}orientation/find-all';

  //Location
  static const String getBestRatedLocations = '${kUrl}location/find-all';
  static const String getLocationsByName = '${kUrl}location/find-all?name=';
  static const String getLocationById = '${kUrl}location';

  //User
  static const String getUser = '${kUrl}user/profile';

  //Review
  static const String doReview = '${kUrl}review/save';
  static const String deleteReview = '${kUrl}review/delete/';
}
