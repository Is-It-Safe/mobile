import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_location.dart';

class SaveLocationUseCase extends SafeUseCase {
  late final ILocationService _service;

  SaveLocationUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<LocationEntity> call({
    required String name,
    required String cep,
    required int locationTypeId,
    String? imgUrl,
  }) async {
    final request = RequestSaveLocation(
      name: name,
      cep: cep,
      locationTypeId: locationTypeId,
      imgUrl: imgUrl,
    );
    final response = await _service.saveLocation(request);
    return LocationEntity.toEntity(response);
  }
}
