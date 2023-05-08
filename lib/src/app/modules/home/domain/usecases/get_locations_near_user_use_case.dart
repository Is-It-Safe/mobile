import 'package:is_it_safe_app/src/app/modules/home/domain/models/request/get_location_near_user_request.dart';
import 'package:is_it_safe_app/src/app/modules/home/services/home_services_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class GetLocationsNearUser extends SafeUseCase {
  final HomeServicesInterface service;

  GetLocationsNearUser(this.service);

  Future<List<LocationEntity>> call(
      {required GetLocationNearUserRequest request}) async {
    final response = await service.getLocationsNearUser(
      request: request,
    );

    return response.map((e) => LocationEntity.toEntity(e)).toList();
  }
}
