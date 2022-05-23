abstract class LoginContract {
  Future<Map<String, dynamic>> doLogin({required String username, required String password});
}