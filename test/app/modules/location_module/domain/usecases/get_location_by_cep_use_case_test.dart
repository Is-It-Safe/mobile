import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_get_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_location_by_cep_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/error/safe_location_error.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/location_mocks.dart';

main() {
  late LocationServiceMock serviceMock;
  late GetLocationByCepUseCase useCaseLocationCep;
  registerFallbackValue(RequestGetLocationByCep(cep: 'fallback_value'));
  const String cep = '49035690';

  setUpAll(() {
    serviceMock = LocationServiceMock();
    useCaseLocationCep = GetLocationByCepUseCase(serviceMock);
  });

  group('GetLocationByCep <Success>', () {
    test('Should return a cep valid', () async {
      when(() => serviceMock.getLocationByCep(any())).thenAnswer(
            (_) async => ResponseLocationByCep(
          cep: '49035690',
        ),
      );

      final response = await useCaseLocationCep(zipCode: cep);

      response.fold((success) {
        expect(success.name, equals(cep));
      }, (failure) {
        expect(failure, null);
      });
    });
  });

  group('GetLocationByCep <Failure>', () {
    test('Should return an invalid cep', () async {
      when(() => serviceMock.getLocationByCep(any())).thenThrow(SafeCepError('Cep inválido'));

      final response = await useCaseLocationCep(zipCode: cep);

      response.fold((success) {
        expect(success, null);
      }, (failure) {
        expect(failure.message, 'Cep inválido');
      });
    });
  });
  
}
