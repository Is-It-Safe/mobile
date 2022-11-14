import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';

abstract class ILocationService {
  Future<List<ResponseGetLocationsById>> getLocationById(int id);
  Future<ResponseGetUserReview> doReview(RequestSaveReview request);
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String place);
  Future<ResponseDeleteReview> deleteReview(int idReview);
}
