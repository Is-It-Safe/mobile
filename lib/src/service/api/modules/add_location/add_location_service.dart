import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/response/response_add_location.dart';

import 'add_location_service_contract.dart';

class AddLocationService implements AddLocationServiceContract {
  final ApiService _service = ApiService();

  @override
  Future addLocationService() async {
    final requestConfig = RequestConfig(
      path: ApiConstants.addLocation,
      method: HttpMethod.post,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBarearAuth(),
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseAddLocation.fromJson(
      json.decode(response.data),
    );
  }
}
