import 'package:shared_preferences/shared_preferences.dart';

import 'custom_shared_preferences_contract.dart';

const String kUsuarioOnBoarding = "onBoarding";
const String kUsuarioLogin = "userLogin";
const String kUsuarioToken = "userToken";
const String kUsuarioRefreshToken = "userRefreshToken";

///O [CustomSharedPreferences] é uma classe responsável por gerenciar e armazenar variádos
///tipos de shared_preferences.
class CustomSharedPreferences implements CustomSharedPreferencesContract {
  ///Salva se o usuário já viu o onBoarding
  @override
  void saveUsuarioOnBoarding(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioOnBoarding, value);
  }

  ///Verifica se o usuário já viu o onBoarding
  Future<bool> readUsuarioOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioOnBoarding) ?? false);
    return result;
  }

  ///Salva se o usuário está logado
  void saveUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioLogin, value);
  }

  ///Verifica se o usuário está logado
  Future<bool> readUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioLogin) ?? false);
    return result;
  }

  ///Salva o token do usuário
  void saveUsuarioToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUsuarioToken, value);
  }

  //Recupera o token do usuário
  Future<String?> readUsuarioToken() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(kUsuarioToken);
    return result;
  }

  ///Salva o refresh token do usuário
  void saveUsuarioRefreshToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUsuarioRefreshToken, value);
  }

  ///Recupera o refresh token do usuário
  Future<String?> readUsuarioRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(kUsuarioRefreshToken);
    return result;
  }
}
