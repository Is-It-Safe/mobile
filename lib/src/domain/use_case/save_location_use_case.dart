import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/add_location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/response/request_add_location.dart';

class SaveLocationUseCase extends SafeUseCase {
  late AddLocationService service;

  SaveLocationUseCase() {
    service = Modular.get<AddLocationService>();
  }

  Future<bool> call({required RequestAddLocation request}) async {
    return service.addLocationService(request: request);
  }
}