import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/search/response/response_get_locations_by_name.dart';
import 'package:is_it_safe_app/src/service/api/modules/search/search_service_interface.dart';

import '../../../../app/modules/search/error/safe_search_error.dart';

class SearchService implements ISearchService {
  final ApiService service = ApiService();
  final AuthService authService;

  SearchService(this.authService);

  @override
  Future<List<ResponseGetLocationsByNameLocation>?> searchLocationByName(
    String locationName,
  ) async {
    try {
      final token = await authService.getAccessToken();
      final path = ApiConstants.getLocationsByName + locationName.trim();
      final requestConfig = RequestConfig(
        path: path,
        method: HttpMethod.get,
        options: Options(
          headers: {
            ApiConstants.kAuthorization: token,
          },
        ),
      );
      final response = await service.doRequest(requestConfig);
      return ResponseGetLocationsByName.fromJson(json.decode(response.data))
          .locations;
    } on DioError catch (e) {
      throw SafeDioResponseSearchError(e.message);
    }
  }
}
