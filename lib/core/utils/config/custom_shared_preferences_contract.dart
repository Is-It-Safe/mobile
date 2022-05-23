abstract class CustomSharedPreferencesContract {
  void saveUsuarioOnBoarding(value);
  Future<bool> readUsuarioOnBoarding();
  void saveUsuario(value);
  Future<bool> readUsuario();
  void saveUsuarioToken(value);
  Future<String?> readUsuarioToken();
  void saveUsuarioRefreshToken(value);
  Future<String?> readUsuarioRefreshToken();
}