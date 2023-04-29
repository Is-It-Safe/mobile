import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_get_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/get_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/profile_service_mock.dart';

void main() {
  late ProfileServiceMock service;
  late GetUserUseCase useCase;

  setUpAll(() {
    service = ProfileServiceMock();
    useCase = GetUserUseCase(service);
  });

  group('GetUserUseCase <Success>', () {
    test('Retorna [UserEntity]', () async {
      when(() => service.getUser())
          .thenAnswer((_) async => ResponseGetUser(id: 1, name: 'Teste'));

      final responseUseCase = await useCase();

      responseUseCase.fold((success) {
        expect(success, isA<UserEntity>());
        expect(success.id, equals(1));
        expect(success.name, equals('Teste'));
      }, (failure) {
        expect(failure, null);
      });
    });
  });

  group('GetUserUseCase <Failure>', () {
    test('Retorna [SafeDioResponseProfileError]', () async {
      when(() => service.getUser())
          .thenThrow(SafeDioResponseProfileError('safe.dio_response.error'));

      final responseUseCase = await useCase();

      responseUseCase.fold((success) {
        expect(success, null);
      }, (failure) {
        expect(failure.message, equals('safe.dio_response.error'));
      });
    });
  });
}
