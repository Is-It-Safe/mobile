import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/auth_mocks.dart';

main() {
  late AuthServiceMock service;
  late DoRegisterUseCase useCase;

  setUpAll(() {
    service = AuthServiceMock();
    useCase = DoRegisterUseCase(service);
  });

  group('DoRegisterUseCase <Success>', () {
    final request = RequestRegister(
      photoUrl: 'path',
      name: 'Fulano',
      nickname: 'fulano_dev',
      email: 'fulanodev@safe.com',
      password: 'password123',
      pronoun: 'ele/ela',
      genderId: 1,
      sexualOrientationId: 1,
      birthDate: '01/01/2000',
    );
    test('Retorna mensagem de ok', () async {
      when(() => service.doRegister(request))
          .thenAnswer((_) async => ResponseRegister(message: "ok"));

      final responseUsecase = await useCase(
        name: request.name!,
        username: request.nickname!,
        password: request.password!,
        email: request.email!,
        birthDate: request.birthDate!,
        sexualOrientation: request.sexualOrientationId!.toString(),
        gender: request.genderId!.toString(),
        profilePhoto: request.photoUrl!,
        pronoun: request.pronoun!,
      );

      responseUsecase.fold(
        (success) {
          expect(success.message, equals("ok"));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });

  group('ConfirmPasswordUseCase <Failure>', () {
    final request = RequestRegister(
      photoUrl: '',
      name: '',
      nickname: '',
      email: '',
      password: '',
      pronoun: '',
      genderId: 0,
      sexualOrientationId: 1,
      birthDate: '',
    );

    test('Retorna <false> caso a senha seja válida', () async {
      when(() => service.doRegister(request))
          .thenAnswer((_) async => ResponseRegister.fromJson(request.toJson()));

      final responseUsecase = await useCase(
        name: request.name!,
        username: request.nickname!,
        password: request.password!,
        email: request.email!,
        birthDate: request.birthDate!,
        sexualOrientation: request.sexualOrientationId!.toString(),
        gender: request.genderId!.toString(),
        profilePhoto: request.photoUrl!,
        pronoun: request.pronoun!,
      );

      responseUsecase.fold(
        (success) {
          expect(success, null);
        },
        (failure) {
          expect(failure, isA<SafeInvalidCredentialsError>());
          expect(failure.message, equals("A senha não pode estar vazia!"));
        },
      );
    });

    test('Testa mensagem de erro', () async {
      final requestErrorMessage =
          RequestConfirmPassword(password: 'password123');
      when(() => service.confirmPassword(requestErrorMessage))
          .thenThrow(SafeDioResponseError("safe.dio_response.error"));

      final responseUsecase = await useCase(
        name: request.name!,
        username: request.nickname!,
        password: request.password!,
        email: request.email!,
        birthDate: request.birthDate!,
        sexualOrientation: request.sexualOrientationId!.toString(),
        gender: request.genderId!.toString(),
        profilePhoto: request.photoUrl!,
        pronoun: request.pronoun!,
      );

      responseUsecase.fold(
        (success) {
          expect(success, null);
        },
        (failure) {
          expect(failure.message, "safe.dio_response.error");
        },
      );
    });
  });
}
