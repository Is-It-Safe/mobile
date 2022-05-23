import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences_contract.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:is_it_safe_app/app/modules/login_module/login_bloc.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/login/login_contract.dart';
import 'package:is_it_safe_app/core/model/Auth.dart';

import 'login_module_test.mocks.dart';

@GenerateMocks([LoginContract, CustomSharedPreferencesContract])
void main() {
  group('login', () {
    const Map<String, dynamic> loginResult = {
      'access_token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
      'token_type': 'userId',
      'refresh_token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
      'expires_in': 86399,
      'scope': 'read write',
      'userFirstName': 'Carlos',
      'userId': 7
    };
    late MockLoginContract loginService;
    late MockCustomSharedPreferencesContract customSharedPreferences;
    late LoginBloc loginBloc;

    setUp(() {
      loginService = MockLoginContract();
      customSharedPreferences = MockCustomSharedPreferencesContract();
      loginBloc = LoginBloc(
          service: loginService,
          customSharedPreferences: customSharedPreferences);
      loginBloc.usernameController.text = '';
      loginBloc.passwordController.text = '';
    });

    test('Login - Expect success when trying to login', () async {
      when(loginService.doLogin(username: '', password: ''))
          .thenAnswer((_) => Future.value(loginResult));
      when(customSharedPreferences.saveUsuario(true)).thenReturn(null);
      when(customSharedPreferences
              .saveUsuarioToken(loginResult['access_token']))
          .thenReturn(null);
      when(customSharedPreferences
              .saveUsuarioRefreshToken(loginResult['refresh_token']))
          .thenReturn(null);

      expect(loginBloc.loginController.stream.last,
          isA<Future<BaseResponse<Auth>>>());
      await loginBloc.doLogin();

      expect(loginBloc.auth, isNotNull);
      verify(customSharedPreferences.saveUsuario(true)).called(1);
      verify(customSharedPreferences
              .saveUsuarioToken(loginResult['access_token']))
          .called(1);
      verify(customSharedPreferences
              .saveUsuarioRefreshToken(loginResult['refresh_token']))
          .called(1);
    });

    test('Login - Expect fail when trying to login', () async {
      when(loginService.doLogin(username: '', password: ''))
          .thenThrow(Exception());
      when(customSharedPreferences.saveUsuario(true)).thenReturn(null);
      when(customSharedPreferences
              .saveUsuarioToken(loginResult['access_token']))
          .thenReturn(null);
      when(customSharedPreferences
              .saveUsuarioRefreshToken(loginResult['refresh_token']))
          .thenReturn(null);

      expect(loginBloc.loginController.stream.last,
          isA<Future<BaseResponse<Auth>>>());
      await loginBloc.doLogin();
      expect(loginBloc.auth, isNull);
      verifyNever(customSharedPreferences.saveUsuario(true));
      verifyNever(customSharedPreferences
          .saveUsuarioToken(loginResult['access_token']));
      verifyNever(customSharedPreferences
          .saveUsuarioRefreshToken(loginResult['refresh_token']));
    });
  });
}
