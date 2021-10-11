import 'package:shared_preferences/shared_preferences.dart';

const String kUsuarioOnBoarding = "onBoarding";
const String kUsuarioLogin = "userLogin";

class CustomSharedPreferences {
  //Salva se o usuário já viu o onBoarding
  static saveUsuarioOnBoarding(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioOnBoarding, value);
  }

  //Verifica se o usuário já viu o onBoarding
  static readUsuarioOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioOnBoarding) ?? false);
    return result;
  }

  static saveUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioLogin, value);
  }

  //Verifica se o usuário está logado
  static readUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioLogin) ?? false);
    return result;
  }
}
