import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/response/response_get_best_rated_locations.dart';

class HomeService implements IHomeService {
  final ApiService _service = ApiService();
  final AuthService _authService;

  HomeService(this._authService);
  @override
  Future<List<ResponseGetBestRatedLocationsLocation>?>
      getBestRatedLocations() async {
    final token = await _authService.getAccessToken();
    final requestConfig = RequestConfig(
      path: ApiConstants.getBestRatedPlaces,
      method: HttpMethod.get,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: token,
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseGetBestRatedLocations.fromJson(json.decode(response.data))
        .locations;
  }
}
