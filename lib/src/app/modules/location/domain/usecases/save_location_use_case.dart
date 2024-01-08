import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/location/error/safe_location_error.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:result_dart/result_dart.dart';

class SaveLocationUseCase extends SafeUseCase {
  final ILocationService service;

  SaveLocationUseCase(this.service);

  Future<Result<LocationEntity, SafeLocationError>> call({
    required String name,
    required String cep,
    required int locationTypeId,
    String? imgUrl,
    required String address, 
  }) async {
    try {
      final request = RequestSaveLocation(
        name: name,
        cep: cep,
        locationTypeId: locationTypeId,
        imgUrl: imgUrl,
        address: address,
      );
      final response = await service.saveLocation(request);
      return Success(LocationEntity.fromResponseSaveLocation(response));
    } on SafeLocationError catch (e) {
      return Failure(e);
    }
  }
}
