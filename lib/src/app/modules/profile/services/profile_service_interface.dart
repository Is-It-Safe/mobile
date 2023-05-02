import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/request_save_review.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_delete_review.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_delete_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_get_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/response/response_update_user.dart';

abstract class IProfileService {
  Future<ResponseGetUser> getUser();

  Future<ResponseDeleteUser> deleteUser({
    required int idUser,
  });

  Future<ResponseUpdateUser> updateUser(RequestUpdateUser request);

  Future<ResponseDeleteReview> deleteReview(int idReview);
  Future<ResponseGetUserReview> saveReview(RequestSaveReview request);

  Future<String> deactivateAccount();
}
