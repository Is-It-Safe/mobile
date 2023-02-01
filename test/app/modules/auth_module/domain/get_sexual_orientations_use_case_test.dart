import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_sexual_orientation.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/auth_mocks.dart';

main() {
  late AuthServiceMock service;
  late GetSexualOrientationsUseCase useCase;

  setUpAll(() {
    service = AuthServiceMock();
    useCase = GetSexualOrientationsUseCase(service);
  });

  group('GetSexualOrientationsUseCase <Success>', () {
    test('Retorna lista de [SexualOrientationEntity]', () async {
      when(() => service.getSexualOrientations()).thenAnswer(
          (_) async => [ResponseSexualOrientation(id: 1, title: 'bissexual')]);

      final responseUsecase = await useCase();

      responseUsecase.fold(
        (success) {
          expect(success.isNotEmpty, true);
          expect(success.single.id, equals(1));
          expect(success.single.title, equals("bissexual"));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });

  group('GetSexualOrientationsUseCase <Failure>', () {
    test('Retorna [SafeDioResponseError]', () async {
      when(() => service.getSexualOrientations())
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
