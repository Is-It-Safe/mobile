import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';

class GetBestRatedLocationsUseCase extends SafeUseCase {
  late final ILocationService _service;

  GetBestRatedLocationsUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<List<LocationEntity>> call({String? place}) async {
    final response = await _service.getBestRatedPlaces(place);
    return response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
