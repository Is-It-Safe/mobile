import 'dart:convert';
import 'dart:io';

import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_update_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_delete_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/request/request_save_review.dart';

class MockReviewService implements IProfileService {
  @override
  Future<ResponseDeleteReview> deleteReview(int idReview) {
    // TODO: implement deleteReview
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
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseGetUser> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<ResponseUpdateUser> updateUser(RequestUpdateUser request) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
