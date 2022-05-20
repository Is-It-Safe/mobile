import 'package:shared_preferences/shared_preferences.dart';

const String kUsuarioOnBoarding = "onBoarding";
const String kUsuarioLogin = "userLogin";
const String kUsuarioToken = "userToken";
const String kUsuarioRefreshToken = "userRefreshToken";

///O [CustomSharedPreferences] é uma classe responsável por gerenciar e armazenar variádos
///tipos de shared_preferences.
class CustomSharedPreferences {
  ///Salva se o usuário já viu o onBoarding
  static saveUsuarioOnBoarding(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioOnBoarding, value);
  }

  ///Verifica se o usuário já viu o onBoarding
  static readUsuarioOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioOnBoarding) ?? false);
    return result;
  }

  ///Salva se o usuário está logado
  static saveUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioLogin, value);
  }

  ///Verifica se o usuário está logado
  static readUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioLogin) ?? false);
    return result;
  }

  ///Salva o token do usuário
  static saveUsuarioToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUsuarioToken, value);
  }

  //Recupera o token do usuário
  static readUsuarioToken() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(kUsuarioToken);
    return result;
  }

  ///Salva o refresh token do usuário
  static saveUsuarioRefreshToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUsuarioRefreshToken, value);
  }

  ///Recupera o refresh token do usuário
  static readUsuarioRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(kUsuarioRefreshToken);
    return result;
  }
}
