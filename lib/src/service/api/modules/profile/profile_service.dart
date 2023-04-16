import 'dart:convert';

import 'package:catcher/catcher.dart';
import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/request_save_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_update_user.dart';

import '../../../../app/modules/configuration/account/error/safe_account_error.dart';
import '../../../../app/modules/profile/error/safe_profile_error.dart';
import 'response/response_delete_user.dart';

class ProfileService implements IProfileService {
  final ApiService _service = ApiService();
  final AuthService _authService;

  ProfileService(this._authService);

  @override
  Future<ResponseGetUser> getUser() async {
    try {
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
    } on DioError catch (e) {
      throw SafeDioResponseProfileError(e.message);
    }
  }

  @override
  Future<ResponseDeleteUser> deleteUser({
    required int idUser,
  }) async {
    try {
      final token = await _authService.getAccessToken();

      final requestConfig = RequestConfig(
        path: ApiConstants.deleteUser + idUser.toString(),
        method: HttpMethod.delete,
        options: Options(
          headers: {ApiConstants.kAuthorization: token},
        ),
      );

      final response = await _service.doRequest(requestConfig);

      return ResponseDeleteUser.fromJson(json.decode(response.data));
    } on DioError catch (e) {
      throw SafeDioResponseProfileError(e.message);
    }
  }

  @override
  Future<ResponseUpdateUser> updateUser(RequestUpdateUser request) async {
    try {
      final token = await _authService.getAccessToken();

      final requestConfig = RequestConfig(
        path: '${ApiConstants.updateUser}/${request.id}',
        method: HttpMethod.put,
        body: request.toJson(),
        options: Options(
          headers: {
            ApiConstants.kAuthorization: token,
          },
        ),
      );

      final response = await _service.doRequest(requestConfig);

      return ResponseUpdateUser.fromJson(json.decode(response.data));
    } on DioError catch (e) {
      throw SafeDioResponseAccountError(e.message);
    }
  }

  @override
  Future<ResponseDeleteReview> deleteReview(int idReview) async {
    try {
      final token = await _authService.getAccessToken();

      final requestConfig = RequestConfig(
        path: ApiConstants.deleteReview + idReview.toString(),
        method: HttpMethod.delete,
        options: Options(
          headers: {ApiConstants.kAuthorization: token},
        ),
      );

      final response = await _service.doRequest(requestConfig);
      return ResponseDeleteReview(message: response.data);
    } on DioError catch (e) {
      throw SafeDioResponseProfileError(e.message);
    }
  }

  @override
  Future<ResponseGetUserReview> saveReview(RequestSaveReview request) async {
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
  Future<String> deactivateAccount() async {
    try {
      final token = await _authService.getAccessToken();

      final requestConfig = RequestConfig(
        path: ApiConstants.deactivateUser,
        method: HttpMethod.delete,
        options: Options(
          headers: {ApiConstants.kAuthorization: token},
        ),
      );

      final response = await _service.doRequest(requestConfig);
      return response.data;
    } on DioError catch (e, stackTrace) {
      Catcher.reportCheckedError(e, stackTrace);
      throw SafeDioResponseProfileError(e.message);
    }
  }
}
