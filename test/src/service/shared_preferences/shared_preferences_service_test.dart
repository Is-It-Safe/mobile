import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';
import 'package:mocktail/mocktail.dart';

import '../../safe_test.dart';

void main() {
  HomeServiceTest().runTests();
}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class HomeServiceTest extends SafeTest {
  late MockSharedPreferencesService _sharedPreferences;

  HomeServiceTest() {
    _sharedPreferences = MockSharedPreferencesService();
  }

  @override
  void runTests() {
    safeGroup(
      description: 'SharedPreferencesService',
      body: () {
        _saveOnBoarding();
        _readOnBoarding();
        _saveLogin();
        _readLogin();
        _saveToken();
        _readToken();
        _saveRefreshToken();
        _readRefreshToken();
        _saveUserAuth();
        _readUserAuth();
      },
    );
  }

  void _saveOnBoarding() {}

  void _readOnBoarding() {}

  void _saveLogin() {}

  void _readLogin() {}

  void _saveToken() {}

  void _readToken() {}

  void _saveRefreshToken() {}

  void _readRefreshToken() {}

  void _saveUserAuth() {}

  void _readUserAuth() {}
}
