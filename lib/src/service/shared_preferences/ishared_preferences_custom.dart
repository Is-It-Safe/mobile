import 'package:dio/dio.dart';

abstract class ISharedPreferencesCustom {
  void saveOnBoarding(bool value);
  Future<bool> readOnBoarding();
  void saveLogin(bool value);
  Future<bool> readLogin();
  void saveToken(String value);
  Future<String> readToken();
  void saveRefreshToken(String value);
  Future<String> readRefreshToken();
  void saveUserAuth(FormData value);
  Future<FormData> readUserAuth();
}
