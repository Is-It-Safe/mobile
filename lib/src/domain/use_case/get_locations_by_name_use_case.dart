import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/search/search_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/search/search_service_interface.dart';

class GetLocationsByNameUseCase extends SafeUseCase {
  late final ISearchService _service;

  GetLocationsByNameUseCase() {
    _service = Modular.get<SearchService>();
  }

  Future<List<LocationEntity>> call(String name) async {
    final _response = await _service.searchLocationByName(name);

    return _response?.map((e) => LocationEntity.toEntity(e)).toList() ?? [];
  }
}
