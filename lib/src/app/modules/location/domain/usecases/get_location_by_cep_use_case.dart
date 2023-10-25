import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_get_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/error/safe_location_error.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:result_dart/result_dart.dart';

class GetLocationByCepUseCase extends SafeUseCase {
  final ILocationService service;

  GetLocationByCepUseCase(this.service);

  Future<Result<LocationEntity, SafeLocationError>> call({
    required String zipCode,
  }) async {
    try {

      final request = RequestGetLocationByCep(
        cep: zipCode,
      );

      final response = await service.getLocationByCep(request);
      return Success(LocationEntity.fromResponseGetLocationByCep(response));
    } on SafeLocationError catch (e) {
      return Failure(e);
    }
  }
}