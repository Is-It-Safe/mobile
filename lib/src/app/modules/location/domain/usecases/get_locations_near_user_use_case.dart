import 'package:is_it_safe_app/src/app/modules/location/services/location_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class GetLocationsNearUser extends SafeUseCase {
  final ILocationService service;

  GetLocationsNearUser(this.service);

  Future<List<LocationEntity>> call(
    double userLatitude,
    double userLongitude,
  ) async {
    final response =
        await service.getLocationsNearUser(userLatitude, userLongitude);

    return response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
