import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/search/error/safe_search_error.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_name_use_case.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/search_service_mock.dart';

void main() {
  late SearchServiceMock service;
  late GetLocationsByNameUseCase useCase;

  setUpAll(() {
    service = SearchServiceMock();
    useCase = GetLocationsByNameUseCase(service);
  });

  group('GetLocationsByNameUseCase <Success>', () {
    test('should return empty list when search for an unknown location',
        () async {
      when(() => service.searchLocationByName('Bar Desconhecido'))
          .thenAnswer((_) async => null);

      final responseUseCase = await useCase('Bar Desconhecido');

      responseUseCase.fold((success) {
        expect(success, []);
      }, (failure) {
        expect(failure, null);
      });
    });
  });

  group('GetLocationsByNameUseCase <Failure>', () {
    test('should return [SafeDioResponseError] when service the service fails',
        () async {
      when(() => service.searchLocationByName('Bar'))
          .thenThrow(SafeDioResponseSearchError('safe.dio_response.error'));

      final responseUseCase = await useCase('Bar');

      responseUseCase.fold((success) {
        expect(success, null);
      }, (failure) {
        expect(failure.message, 'safe.dio_response.error');
      });
    });
  });
}
