import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/auth_mocks.dart';

main() {
  late AuthServiceMock service;
  late ConfirmPasswordUseCase useCase;

  setUpAll(() {
    service = AuthServiceMock();
    useCase = ConfirmPasswordUseCase(service);
  });

  group('ConfirmPasswordUseCase <Success>', () {
    final request = RequestConfirmPassword(password: 'password123');
    test('Retorna <true> caso a senha seja válida', () async {
      when(() => service.confirmPassword(request))
          .thenAnswer((_) async => true);

      final responseUsecase = await useCase(request);

      responseUsecase.fold(
        (success) {
          expect(success, true);
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });

  group('ConfirmPasswordUseCase <Failure>', () {
    final request = RequestConfirmPassword(password: '');

    test('Retorna <false> caso a senha seja válida', () async {
      when(() => service.confirmPassword(request))
          .thenAnswer((_) async => false);

      final responseUsecase = await useCase(request);

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

      final responseUsecase = await useCase(requestErrorMessage);

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
