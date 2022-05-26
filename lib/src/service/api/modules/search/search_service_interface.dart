import 'package:is_it_safe_app/src/service/api/modules/search/response/response_get_locations_by_name.dart';

abstract class ISearchService {
  Future<List<ResponseGetLocationsByNameLocation>?> searchLocationByName(
      String locationName);
}
