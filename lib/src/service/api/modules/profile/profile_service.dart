import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_update_user.dart';

class ProfileService implements IProfileService {
  final ApiService _service = ApiService();
  final AuthService _authService;

  ProfileService(this._authService);

  @override
  Future<ResponseGetUser> getUser() async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: ApiConstants.getUser,
      method: HttpMethod.get,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: token,
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return ResponseGetUser.fromJson(json.decode(response.data));
  }

  @override
  Future<ResponseUpdateUser> updateUser(int id) async {
    final token = await _authService.getAccessToken();

    final requestConfig = RequestConfig(
      path: '${ApiConstants.updateUser}/$id',
      method: HttpMethod.put,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: token,
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);
    return ResponseUpdateUser.fromJson(json.decode(response.data));
  }
}
