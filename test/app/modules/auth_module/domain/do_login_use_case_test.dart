import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/entities/request/request_login.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/usecases/do_login_use_case.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/mock_auth_service.dart';

class DoLoginSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => MockAuthService()),
        Bind((i) => DoLoginUseCase(i.get<MockAuthService>())),
      ];
}

main() {
  group('DoLoginUseCase <Success>', () {
    setUpAll(() {
      initModule(DoLoginSuccessTestModule());
    });

    test('Testa se o login é realizado com sucesso', () async {
      final request =
          RequestLogin(email: 'basic@gmail.com', password: '123456');

      final usecase = Modular.get<DoLoginUseCase>();

      final response =
          await usecase.call(email: request.email, password: request.password);

      response.fold(
        (success) {
          expect(
              success.userImage,
              equals(
                  "images/modules/auth/profile_pictures/profile_pic_13.png"));
          expect(success.userFirstName, equals("Bruni Pinho TESTE 3"));
          expect(success.userId, equals(3));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });
}
