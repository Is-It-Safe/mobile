import 'dart:convert';
import 'package:is_it_safe_app/src/core/util/flavor_util.dart';

/// [ApiConstants] é uma classe que contém todas as constantes usadas nas requisições da API
class ApiConstants {
  ///URL representando webhook para monitoramento da aplicação.
  static const String kDiscordMonitoringWebhook =
      'https://discord.com/api/webhooks/1086465967468597298/BoP0DfykuMDBCsc-XM8e2d8mdapE-TT4Zjtu6m2t_gfyv2EPILuJUz3n27bXY82ekRYB';

  ///Credenciais de autenticação
  static const String kClientCredentials = 'isitsafe:isitsafe123';
  static const String kAuthorization = 'Authorization';
  static const String kContentType = 'Content-Type';

  ///Base64 de credenciais de autenticação
  static String kEncodedClientCredentials = base64Encode(
    utf8.encode(kClientCredentials),
  );

  ///Basic Auth para autenticação do Login
  static String kBasicAuth = 'Basic $kEncodedClientCredentials';

  ///URL para requisições de autenticação
  static const String kDevelopUrl = 'https://is-it-safe-api-v2.herokuapp.com';
  static const String kProductionUrl = 'https://api.isitsafe.com.br';

  ///Url default para requisições da API
  static String kUrl = '${FlavorUtil.instance.url}/is-it-safe/';

  ///URL para requisições voltadas a localização via CEP
  static const String kUrlCep = 'viacep.com.br/ws/cep/json/';

  ///URL para direcionar usuario a pagina web de esqueceu a senha
  static String kForgotPassword =
      '${FlavorUtil.instance.url}/is-it-safe/forgot';
  /*--------------------------------------------------------------------*/

  //Auth
  static String doAuth = '${kUrl}auth/login';
  static String doRefresh = '${kUrl}auth/refreshtoken';
  static String doRegister = '${kUrl}user/save';
  static String getGenders = '${kUrl}gender/find-all';
  static String getSexualOrientations = '${kUrl}orientation/find-all';
  static String confirmPassword = '${kUrl}user/is-password-correct';
  static String isUsernameAvailable = '${kUrl}user/is-nickname-available/';
  static String isEmailAvailable = '${kUrl}user/is-email-already-used/';

  //Location
  static String getBestRatedLocations = '${kUrl}location/find-all';
  static String getLocationsByName = '${kUrl}location/find-all?name=';
  static String getLocationById = '${kUrl}location';
  static String addLocation = '${kUrl}location/save';
  static String getBestRatedLocationsByCity =
      '${kUrl}location/trending?cityName=';
  static String getLocationsNearUser = '${kUrl}location/near?';

  //User
  static String getUser = '${kUrl}user/profile';
  static String deleteUser = '${kUrl}user/delete/';
  static String updateUser = '${kUrl}user/update';
  static String deactivateUser = '${kUrl}user/deactivate';

  //Review
  static String doReview = '${kUrl}review/save';
  static String deleteReview = '${kUrl}review/delete/';
}
