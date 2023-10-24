import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_get_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_location_by_cep_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_location_use_case.dart';
import 'package:modular_test/modular_test.dart';

import '../../mocks/mock_location_service.dart';


class GetLocationByCepSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => MockLocationService()),
    Bind((i) => GetLocationByCepUseCase(i.get<MockLocationService>())),
  ];
}

main() {
  setUpAll(() {
    initModule(GetLocationByCepSuccessTestModule());
  });

  group('GetLocationByCep <Succes>', () {
    final request = RequestGetLocationByCep(
      cep: '41000000',
    );
    test('Should return a cep valid', () async {
      final useCase = Modular.get<GetLocationByCepUseCase>();

      final getLocationByCepUseCase = await useCase(
        zipCode: request.cep!,
      );

      getLocationByCepUseCase.fold(
            (success) {
          expect(success.name, equals("41000000"));
        },
            (failure) {},
      );
    });
  });
}
