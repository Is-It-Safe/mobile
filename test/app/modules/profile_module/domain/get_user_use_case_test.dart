import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
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
          .thenAnswer((_) async => ResponseGetUser(id: 1));

      final responseUseCase = await useCase();

      responseUseCase.fold((success) {
        expect(success, isA<UserEntity>());
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
        expect(failure.message, 'safe.dio_response.error');
      });
    });
  });
}
