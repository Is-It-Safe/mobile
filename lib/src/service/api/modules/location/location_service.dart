import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_post_review.dart';

import '../../configuration/api_service.dart';
import '../../configuration/request_config.dart';
import '../../constants/api_constants.dart';
import 'response/response_get_location_by_id.dart';

class LocationService implements ILocationService {
  final ApiService _service = ApiService();
  
  @override
  Future<List<ResponseGetLocationsById>> getLocationById(
      {required int locationId}) async {
    final requestConfig = RequestConfig(
      path: '${ApiConstants.getLocationById}/$locationId',
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGetLocationsById.fromJson(e))
        .toList();
  }

  @override
  Future doReview(RequestReview request) async {
    RequestConfig(
      path: ApiConstants.doAuth,
      method: HttpMethod.post,
      body: request.toJson(request),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBasicAuth,
          ApiConstants.kContentType: 'application/x-www-form-urlencoded',
        },
      ),
    );
  }
}
