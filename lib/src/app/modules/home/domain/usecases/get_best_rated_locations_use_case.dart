import 'package:is_it_safe_app/src/app/modules/home/services/home_services_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class GetBestRatedLocationsUseCase extends SafeUseCase {
  final HomeServicesInterface service;

  GetBestRatedLocationsUseCase(this.service);

  Future<List<LocationEntity>> call({String? place}) async {
    final response = await service.getBestRatedPlaces(place);
    return response
        .map((e) => LocationEntity.fromGetBestRatedPlaces(e))
        .toList();
  }
}
