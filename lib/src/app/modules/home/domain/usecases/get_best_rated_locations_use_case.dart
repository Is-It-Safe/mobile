import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/home/services/home_services_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class GetBestRatedLocationsUseCase extends SafeUseCase {
  final HomeServicesInterface service;

  GetBestRatedLocationsUseCase(this.service);

  Future<List<LocationEntity>> call({String? place}) async {
    List<ResponseGetRatedPlaces> response =
        await service.getBestRatedPlaces(place);

    if (response.isEmpty) {
      response = await service.getBestRatedPlaces(null);
    }
    return response
        .map((e) => LocationEntity.fromGetBestRatedPlaces(e))
        .toList();
  }
}
