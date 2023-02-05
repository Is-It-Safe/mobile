import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/auth_mocks.dart';
import '../mocks/mock_auth_service.dart';

class MockDio extends Mock implements Dio {}

class DoLoginSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => MockDio()),
        Bind((i) => MockAuthService(i.get<Dio>())),
        Bind((i) => DoLoginUseCase(i.get<MockAuthService>())),
      ];
}

main() {
  // late AuthServiceMock service;
  // late DoLoginUseCase useCase;

  setUpAll(() {
    // service = AuthServiceMock();
    // useCase = DoLoginUseCase(service);
    initModule(DoLoginSuccessTestModule());
  });

  group('DoLoginUseCase <Success>', () {
    test('test name', () async {
      final request =
          RequestLogin(email: 'basic@gmail.com', password: '123456');

      // when(() => service.doLogin(request))
      //     .thenAnswer((_) async => ResponseLogin(
      //           accessToken: 'fdu43-dfh33-fs9df8s-dsdan32k-ck2sa21',
      //           tokenType: 'token',
      //           refreshToken: 'dfh33-fdu43-fs9df8s-ck2sa21-dsdan32k',
      //           userFirstName: 'Fulano',
      //           expiresIn: 5,
      //           scope: 'scope',
      //           userImage: 'path',
      //           userId: 1,
      //         ));

      // final responseUsecase =
      //     await useCase(email: 'basic@gmail.com', password: '123456');

      final usecase = Modular.get<DoLoginUseCase>();

      final response =
          await usecase.call(email: request.email, password: request.password);

      response.fold(
        (success) {
          expect(success.accessToken,
              equals("fdu43-dfh33-fs9df8s-dsdan32k-ck2sa21"));
          expect(success.userFirstName, equals("Fulano"));
          expect(success.userId, equals(1));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });
}
