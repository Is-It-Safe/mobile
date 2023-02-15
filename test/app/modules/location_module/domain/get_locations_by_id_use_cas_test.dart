import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/location/error/safe_location_error.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/location_mocks.dart';

main() {
  late LocationServiceMock serviceMock;
  late GetLocationsByIdUseCase getLocationsByIdUseCase;
  const int locationId = 1;

  setUpAll(() {
    serviceMock = LocationServiceMock();
    getLocationsByIdUseCase = GetLocationsByIdUseCase(serviceMock);
  });

  group('GetLocationsByIdUseCase <Success>', () {
    test('Retorna local pelo [LocationEntity]', () async {
      when(() => serviceMock.getLocationById(locationId)).thenAnswer(
        (_) async => ResponseGetLocationsById(
            id: 1, name: 'Restaurante Paraíso da Carne de Sol'),
      );

      final responseUseCase = await getLocationsByIdUseCase(locationId);
      responseUseCase.fold(
        (success) {
          expect(success.id, equals(locationId));
          expect(success.name, equals("Restaurante Paraíso da Carne de Sol"));
        },
        (failure) {
          expect(failure, null);
        },
      );
    });
  });
  group('GetLocationsByIdUseCase <Failure>', () {
    test('Retorna [SafeDioResponseLocationError]', () async {
      when(() => serviceMock.getLocationById(locationId))
          .thenThrow(SafeDioResponseLocationError("safe.dio_response.error"));

      final responseUseCase = await getLocationsByIdUseCase(locationId);

      responseUseCase.fold(
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
