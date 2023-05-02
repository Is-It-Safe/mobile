import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/search/search_service_interface.dart';
import 'package:result_dart/result_dart.dart';

import '../../../search/error/safe_search_error.dart';

class GetLocationsByNameUseCase extends SafeUseCase {
  final ISearchService service;

  GetLocationsByNameUseCase(this.service);

  Future<Result<List<LocationEntity>, SafeSearchError>> call(
      String name) async {
    try {
      final response = await service.searchLocationByName(name);
      return Success(response
              ?.map((e) => LocationEntity.fromResponseSearchLocationByName(e))
              .toList() ??
          []);
    } on SafeSearchError catch (e) {
      return Failure(e);
    }
  }
}
