import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/auth_mocks.dart';

main() {
  late AuthServiceMock service;
  late DoLoginUseCase useCase;

  setUpAll(() {
    service = AuthServiceMock();
    useCase = DoLoginUseCase(service);
  });

  group('DoLoginUseCase <Success>', () {
    test('test name', () async {
      final request =
          RequestLogin(email: 'email@gmail.com', password: 'password123');

      when(() => service.doLogin(request))
          .thenAnswer((_) async => ResponseLogin(
                accessToken: 'fdu43-dfh33-fs9df8s-dsdan32k-ck2sa21',
                userFirstName: 'Fulano',
                userId: 1,
              ));

      final responseUsecase =
          await useCase(email: 'email@gmail.com', password: 'password123');

      responseUsecase.fold(
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
