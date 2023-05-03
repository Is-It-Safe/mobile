import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/models/response/response_get_best_rated_places.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_get_location_by_id.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_by_cep.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service_interface.dart';

import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';

class LocationService implements ILocationService {
  final ApiService _service = ApiService();
  final AuthService _authService;

  LocationService(this._authService);

  @override
  Future<ResponseGetLocationsById> getLocationById(int id) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: '${ApiConstants.getLocationById}/$id',
      method: HttpMethod.get,
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    if (kDebugMode) {
      print((json.decode(response.data)));
    }
    final data = (json.decode(response.data) as Map<String, dynamic>);
    return ResponseGetLocationsById.fromJson(data);
  }

  @override
  Future<ResponseLocationByCep> getLocationByCep(int cep) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: ApiConstants.kUrlCep.replaceAll('cep', cep.toString()),
      method: HttpMethod.get,
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return ResponseLocationByCep.fromJson(json.decode(response.data));
  }

  @override
  Future<ResponseSaveLocation> saveLocation(RequestSaveLocation request) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: ApiConstants.addLocation,
      method: HttpMethod.post,
      body: request.toFormData(request),
      options: Options(
        headers: {ApiConstants.kAuthorization: token},
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return ResponseSaveLocation.fromJson(json.decode(response.data));
  }
}
