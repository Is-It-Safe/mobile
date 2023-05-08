import 'package:is_it_safe_app/src/app/modules/home/domain/models/request/get_location_near_user_request.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_locations_near_user.dart';

abstract class HomeServicesInterface {
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String? place);
  Future<List<ResponseGetLocationsNearUser>> getLocationsNearUser({required GetLocationNearUserRequest request});
}
