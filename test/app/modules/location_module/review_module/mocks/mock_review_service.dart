import 'dart:convert';
import 'dart:io';

import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/request_save_review.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_delete_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_get_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';

class MockReviewService implements IProfileService {
  @override
  Future<ResponseDeleteReview> deleteReview(int idReview) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseGetUserReview> saveReview(RequestSaveReview request) async {
    return ResponseGetUserReview.fromJson(
      jsonDecode(File(
              "test/app/modules/location_module/review_module/savereview_response.json")
          .readAsStringSync()),
    );
  }

  @override
  Future<ResponseDeleteUser> deleteUser({required int idUser}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseGetUser> getUser() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseUpdateUser> updateUser(RequestUpdateUser request) {
    throw UnimplementedError();
  }

  @override
  Future<String> deactivateAccount() {
    throw UnimplementedError();
  }
}
