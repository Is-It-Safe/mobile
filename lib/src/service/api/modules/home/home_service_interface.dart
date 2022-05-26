import 'package:is_it_safe_app/src/service/api/modules/home/response/response_get_best_rated_locations.dart';

abstract class IHomeService {
  Future<List<ResponseGetBestRatedLocationsLocation>?> getBestRatedLocations();
}
