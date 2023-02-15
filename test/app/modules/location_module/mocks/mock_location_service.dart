import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_save_location.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_locations_near_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_location.dart';

class MockLocationService implements ILocationService {
  @override
  Future<ResponseGetLocationsById> getLocationById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String? place) {
    // TODO: implement getBestRatedPlaces
    throw UnimplementedError();
  }

  @override
  Future<void> getLocationByCep(int cep) {
    // TODO: implement getLocationByCep
    throw UnimplementedError();
  }

  @override
  Future<List<ResponseGetLocationsNearUser>> getLocationsNearUser(
      double userLatitude, double userLongitude) {
    // TODO: implement getLocationsNearUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseSaveLocation> saveLocation(RequestSaveLocation request) {
    // TODO: implement saveLocation
    throw UnimplementedError();
  }
}
