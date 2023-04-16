import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/request/request_register.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/do_register_use_case.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/mock_auth_service.dart';

class DoRegisterSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => MockAuthService()),
        Bind((i) => DoRegisterUseCase(i.get<MockAuthService>())),
      ];
}

main() {
  setUpAll(() {
    initModule(DoRegisterSuccessTestModule());
  });

  group('DoRegisterUseCase <Success>', () {
    final request = RequestRegister(
      photoUrl: 'path/new_path/picture.png',
      name: 'Fulano',
      nickname: 'fulano_dev',
      email: 'fulanodev@safe.com',
      password: 'password123',
      pronoun: 'ele/ela',
      genderId: 3,
      sexualOrientationId: 5,
      birthDate: '01-01-2003',
    );
    test('Testa se o cadastro foi realizado com sucesso', () async {
      final usecase = Modular.get<DoRegisterUseCase>();

      final responseUsecase = await usecase(
        name: request.name!,
        username: request.nickname!,
        password: request.password!,
        email: request.email!,
        birthDate: request.birthDate!,
        sexualOrientation: request.sexualOrientationId!,
        gender: request.genderId!,
        profilePhoto: request.photoUrl!,
        pronoun: request.pronoun!,
      );

      responseUsecase.fold(
        (success) {
          expect(success.message, equals("Usuário Registrado com sucesso !"));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });
}
