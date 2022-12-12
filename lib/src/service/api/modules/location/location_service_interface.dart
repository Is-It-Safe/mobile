import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_locations_near_user.dart';

abstract class ILocationService {
  Future<List<ResponseGetLocationsById>> getLocationById(int id);
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String? place);
  Future<void> getLocationByCep(int cep);
  Future<List<ResponseGetLocationsNearUser>> getLocationsNearUser(
    double userLatitude,
    double userLongitude,
  );
}
