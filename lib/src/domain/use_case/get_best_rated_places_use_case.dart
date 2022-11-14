import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

import '../../service/api/modules/location/location_service.dart';
import '../../service/api/modules/location/location_service_interface.dart';

class GetBestRatedPlacesUseCase extends SafeUseCase {
  late final ILocationService _service;

  GetBestRatedPlacesUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<List<LocationEntity>> call(String place) async {
    final _response = await _service.getBestRatedPlaces(place);
    return _response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
