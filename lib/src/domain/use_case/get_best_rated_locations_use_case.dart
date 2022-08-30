import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service_interface.dart';

class GetBestRatedLocationsUseCase extends SafeUseCase {
  late final IHomeService _service;

  GetBestRatedLocationsUseCase() {
    _service = Modular.get<HomeService>();
  }

  Future<List<LocationEntity>> call() async {
    final _response = await _service.getBestRatedLocations();
    return _response?.map((e) => LocationEntity.toEntity(e)).toList() ?? [];
  }
}
