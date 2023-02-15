import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_location.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks/mock_location_service.dart';

class SaveLocationSuccessTestModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => MockLocationService()),
        Bind((i) => SaveLocationUseCase(i.get<MockLocationService>())),
      ];
}

main() {
  setUpAll(() {
    initModule(SaveLocationSuccessTestModule());
  });

  group('SaveLocationUseCase <Succes>', () {
    final request = RequestSaveLocation(
      name: 'Testes de Dominio',
      cep: '41000000',
      locationTypeId: 1,
      imgUrl: 'path/new_path/image.jpg',
    );
    test('Retorna local salvo com sucesso', () async {
      final useCase = Modular.get<SaveLocationUseCase>();

      final saveLocationUseCase = await useCase(
        name: request.name!,
        cep: request.cep!,
        locationTypeId: request.locationTypeId!,
        imgUrl: request.imgUrl!,
      );

      saveLocationUseCase.fold(
        (success) {
          expect(success.name, equals("Testes de Dominio"));
        },
        (failure) {},
      );
    });
  });
  group('SaveLocationUseCase <Failure>', () {});
}
