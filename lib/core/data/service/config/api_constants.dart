import 'package:dio/dio.dart';

class ApiConstants {
  static String kBaseUrl =
      "https://is-it-safe-api-homolog.herokuapp.com/is-it-safe/";

  static String kApiKey = "";

  static Options kOptions = Options(headers: {
    'Content-Type': 'application/json',
  });

  static Map<String, dynamic> kqueryParameters = {};
}
