import 'package:dio/dio.dart';

class ApiConstants {
  static const String kBaseUrl =
      "https://is-it-safe-api-homolog.herokuapp.com/is-it-safe/";
  static const String kAuthUtl =
      'https://is-it-safe-api-homolog.herokuapp.com/oauth/token';

  static const String kClientId = 'isitsafe';
  static const String kClientSecret = 'isitsafe123';

  static Options kOptions = Options(headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  });

  static const Map<String, dynamic> kqueryParameters = {};
}
