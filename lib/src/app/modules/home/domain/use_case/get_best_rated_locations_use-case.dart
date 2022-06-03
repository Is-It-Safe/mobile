import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/entity/home_location_entity.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/response/response_get_best_rated_locations.dart';

class GetBestRatedLocationsUseCase extends SafeUseCase {
  late final IHomeService _service;

  GetBestRatedLocationsUseCase() {
    _service = Modular.get<HomeService>();
  }

  Future<List<HomeLocationEntity>> call() async {
    final _response = await _service.getBestRatedLocations();

    return _parseResponseToEntity(_response);
  }

  List<HomeLocationEntity> _parseResponseToEntity(
    List<ResponseGetBestRatedLocationsLocation>? response,
  ) {
    final listLocations = <HomeLocationEntity>[];

    for (final location in response ?? []) {
      final entity = HomeLocationEntity(
        id: location.id ?? IntConstants.empty,
        name: location.name ?? StringConstants.empty,
        address: location.endereco ?? StringConstants.empty,
        averageGrade: location.averageGrade ?? IntConstants.empty,
        reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
        imagePath: location.imgUrl ?? StringConstants.empty,
      );
      listLocations.add(entity);
    }

    return listLocations;
  }
}
