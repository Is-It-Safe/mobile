import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_add_location.dart';

// class SaveLocationUseCase extends SafeUseCase {
//   late AddLocationService service;

//   SaveLocationUseCase() {
//     service = Modular.get<AddLocationService>();
//   }

//   Future<bool> call({required RequestAddLocation request}) async {
//     return service.addLocationService(request: request);
//   }
// }

class SaveLocationUseCase extends SafeUseCase {
  late final ILocationService _service;

  SaveLocationUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<LocationEntity> call({
    required String name,
    required String cep,
    required int locationTypeId,
    required String file,
  }) async {
    final request = RequestAddLocation(
      name: name,
      cep: cep,
      locationTypeId: locationTypeId,
      file: file,
    );
    final response = await _service.addLocation(request);
    return LocationEntity.toEntity(response);
  }
}
