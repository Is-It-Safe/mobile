import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';

class GetLocationsNearUser extends SafeUseCase {
  late final ILocationService _service;

  GetLocationsNearUser() {
    _service = Modular.get<LocationService>();
  }

  Future<List<LocationEntity>> call(
    double userLatitude,
    double userLongitude,
  ) async {
    final _response =
        await _service.getLocationsNearUser(userLatitude, userLongitude);

    return _response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
