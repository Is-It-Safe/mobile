import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/request/get_location_near_user_request.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_locations_near_user.dart';
import 'package:is_it_safe_app/src/app/modules/home/services/home_services_interface.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

class HomeServices implements HomeServicesInterface {
  final ApiService _service = ApiService();
  final AuthService _authService;

  HomeServices(this._authService);

  @override
  Future<List<ResponseGetRatedPlaces>> getBestRatedPlaces(String? place) async {
    final token = await _authService.getAccessToken();

    final path = place == null
        ? ApiConstants.getBestRatedLocations
        : '${ApiConstants.getBestRatedLocationsByCity}$place';

    final requestConfig = RequestConfig(
      path: path,
      method: HttpMethod.get,
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGetRatedPlaces.fromJson(e))
        .toList();
  }

  @override
  Future<List<ResponseGetLocationsNearUser>> getLocationsNearUser({
    required GetLocationNearUserRequest request,
  }) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path:
          '${ApiConstants.getLocationsNearUser}latitude=${request.latitude}&longitude=${request.longitude}',
      method: HttpMethod.get,
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    final map = (json.decode(response.data) as Map<String, dynamic>);
    return (map['content'] as List)
        .map((e) => ResponseGetLocationsNearUser.fromJson(e))
        .toList();
  }
}
