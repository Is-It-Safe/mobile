import 'package:is_it_safe_app/src/app/modules/location/error/safe_location_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:result_dart/result_dart.dart';

class GetLocationsByIdUseCase extends SafeUseCase {
  late final ILocationService service;

  GetLocationsByIdUseCase(this.service);

  Future<Result<LocationEntity, SafeLocationError>> call(int id) async {
    try {
      final response = await service.getLocationById(id);

      return Success(LocationEntity.toEntity(response));
    } on SafeLocationError catch (e) {
      return Failure(e);
    }
  }
}
