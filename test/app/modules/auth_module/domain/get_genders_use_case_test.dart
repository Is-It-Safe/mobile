import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_gender.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/auth_mocks.dart';

main() {
  late AuthServiceMock service;
  late GetGendersUseCase useCase;

  setUpAll(() {
    service = AuthServiceMock();
    useCase = GetGendersUseCase(service);
  });

  group('GetGendersUseCase <Success>', () {
    test('Retorna lista de [GenderEntity]', () async {
      when(() => service.getGenders())
          .thenAnswer((_) async => [ResponseGender(id: 1, title: 'Homem cis')]);

      final responseUsecase = await useCase();

      responseUsecase.fold(
        (success) {
          expect(success.isNotEmpty, true);
          expect(success.single.id, equals(1));
          expect(success.single.title, equals("Homem cis"));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });

  group('GetGendersUseCase <Failure>', () {
    test('Retorna [SafeDioResponseError]', () async {
      when(() => service.getGenders())
          .thenThrow(SafeDioResponseError("safe.dio_response.error"));

      final responseUsecase = await useCase();

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
