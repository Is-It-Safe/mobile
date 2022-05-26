import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../safe_test.dart';

void main() {
  AuthServiceTest().runTests();
}

class MockAuthService extends Mock implements IAuthService {}

class AuthServiceTest extends SafeTest {
  late MockAuthService _authService;

  AuthServiceTest() {
    _authService = MockAuthService();
  }

  @override
  void runTests() {
    safeGroup(
      description: 'AuthService',
      body: () {
        _doLogin();
        _doRefreshToken();
        _doRegister();
        _getGenders();
        _getSexualOrientations();
      },
    );
  }

  void _doLogin() {}

  void _doRefreshToken() {}

  void _doRegister() {}

  void _getGenders() {}

  void _getSexualOrientations() {}
}
