import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
import 'response/response_get_location_by_id.dart';

class LocationService implements ILocationService {
  final ApiService _service = ApiService();
  final AuthService _authService;

  LocationService(this._authService);

  @override
  Future<List<ResponseGetLocationsById>> getLocationById(int id) async {
    final requestConfig = RequestConfig(
      path: '${ApiConstants.getLocationById}/$id',
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGetLocationsById.fromJson(e))
        .toList();
  }

  @override
  Future<ResponseGetUserReview> doReview(RequestSaveReview request) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: ApiConstants.doReview,
      method: HttpMethod.post,
      body: request.toJson(request),
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return ResponseGetUserReview.fromJson(json.decode(response.data));
  }

  @override
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String place) async {
    final requestConfig = RequestConfig(
      path: '${ApiConstants.getBestRatedPlaces}$place',
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGetRatedPlaces.fromJson(e))
        .toList();
  }
}
