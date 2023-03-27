import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/error/safe_account_error.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_update_user.dart';
import 'package:mocktail/mocktail.dart';
import '../mocks/profile_service_mock.dart';

void main() {
  late ProfileServiceMock service;
  late UpdateUserUseCase useCase;

  setUpAll(() {
    service = ProfileServiceMock();
    useCase = UpdateUserUseCase(service);
  });

  group('UpdateUserUseCase <Success>', () {
    test('Retorna [UserEntity]', () async {
      final request = RequestUpdateUser(id: 1);

      when(() => service.updateUser(request))
          .thenAnswer((_) async => ResponseUpdateUser(id: 1, name: 'Teste'));

      final responseUseCase = await useCase(request);

      responseUseCase.fold((success) {
        expect(success, isA<UserEntity>());
        expect(success.id, equals(1));
        expect(success.name, equals('Teste'));
      }, (failure) {
        expect(failure, null);
      });
    });
  });

  group('UpdateUserUseCase <Failure>', () {
    test('Retorna [SafeDioResponseAccountError]', () async {
      final request = RequestUpdateUser(id: 1);

      when(() => service.updateUser(request))
          .thenThrow(SafeDioResponseAccountError('safe.dio_response.error'));

      final responseUseCase = await useCase(request);

      responseUseCase.fold((success) {
        expect(success, null);
      }, (failure) {
        expect(failure.message, equals('safe.dio_response.error'));
      });
    });
  });
}
