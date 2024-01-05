import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/constants/key_constants.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

///A classe de [SharedPreferencesService] é uma classe responsável por gerenciar
///e armazenar requisições de armazenamento de dados locais.
class SharedPreferencesService implements ISharedPreferencesService {
  @override
  void saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(KeyConstants.keyUserLogged, value);
  }

  @override
  Future<bool> readLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstants.keyUserLogged) ?? false;
  }

  @override
  void saveOnBoarding(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(KeyConstants.keyUserOnBoarding, value);
  }

  @override
  Future<bool> readOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstants.keyUserOnBoarding) ?? false;
  }

  @override
  void saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyUserToken, value);
  }

  @override
  Future<String> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstants.keyUserToken) ?? StringConstants.empty;
  }

  @override
  void saveRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyUserRefreshToken, value);
  }

  @override
  Future<String> readRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstants.keyUserRefreshToken) ??
        StringConstants.empty;
  }

  @override
  void saveUserAuth(FormData value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyUserAuth, value.toString());
  }

  @override
  Future<FormData> readUserAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return FormData.fromMap(
      json.decode(
        prefs.getString(KeyConstants.keyUserAuth) ?? StringConstants.empty,
      ),
    );
  }

  @override
  void saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(KeyConstants.keyTheme, value);
  }

  @override
  Future<bool> readTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstants.keyTheme) ?? false;
  }

  @override
  void saveUserName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyUserName, value);
  }

  @override
  Future<String> readUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstants.keyUserName) ?? StringConstants.empty;
  }

  @override
  void saveUserImage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyUserImage, value);
  }

  @override
  Future<String> readUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstants.keyUserImage) ?? StringConstants.empty;
  }

  @override
  void savePlace(Placemark value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(KeyConstants.keyPlace, value.toJson().toString());
  }

  @override
  Future<Placemark> readPlace() async {
    final prefs = await SharedPreferences.getInstance();
    bool result = prefs.containsKey(KeyConstants.keyPlace);
    if (!result) prefs.setString(KeyConstants.keyPlace, StringConstants.place);
    return Placemark.fromMap(
      jsonDecode(prefs.getString(KeyConstants.keyPlace) ?? "") ??
          StringConstants.empty,
    );
  }

  @override
  Future<bool> readLocationPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KeyConstants.locationPermission) ?? false;
  }

  @override
  void saveLocationPermission(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(KeyConstants.locationPermission, value);
  }

  @override
  Future<void> saveUserEmail({required String userEmail}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyConstants.keyUserEmail, userEmail);
  }

  @override
  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(KeyConstants.keyUserEmail) ?? StringConstants.empty;
  }
}
