import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/response/request_add_location.dart';

import 'add_location_service_contract.dart';

class AddLocationService implements AddLocationServiceContract {
  final ApiService _service = ApiService();

  @override
  Future<bool> addLocationService({
    required RequestAddLocation request,
  }) async {
    final auth = await ApiConstants.kBarearAuth();
    final requestConfig = RequestConfig(
      path: ApiConstants.addLocation,
      method: HttpMethod.post,
      body: request.toJson(),
      options: Options(
        headers: {
          ApiConstants.kAuthorization: auth,
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
