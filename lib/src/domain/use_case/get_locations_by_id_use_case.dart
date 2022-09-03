import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';

class GetLocationsByIdUseCase extends SafeUseCase {
  late final ILocationService _service;

  GetLocationsByIdUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<List<LocationEntity>> call(int id) async {
    final response = await _service.getLocationById(id);

    return response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
