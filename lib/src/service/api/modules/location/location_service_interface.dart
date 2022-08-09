import 'package:is_it_safe_app/src/service/api/modules/location/request/request_post_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';

abstract class ILocationService {
  Future<List<ResponseGetLocationsById>> getLocationById({required int locationId});
  Future doReview(RequestReview request);
}
