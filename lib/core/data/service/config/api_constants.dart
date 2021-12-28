import 'package:dio/dio.dart';

class ApiConstants {
  static const String kBaseUrl =
      "https://is-it-safe-api-homolog.herokuapp.com/is-it-safe/";

  static const String kClientId = 'isitsafe';
  static const String kClientSecret = 'isitsafe123';

  static Options kOptions = Options(headers: {});

  static const Map<String, dynamic> kqueryParameters = {};
}
