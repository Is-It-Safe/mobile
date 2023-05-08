import 'package:is_it_safe_app/src/app/modules/configuration/account/error/safe_account_error.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';
import 'package:result_dart/result_dart.dart';

class UpdateUserUseCase extends SafeUseCase {
  final IProfileService _service;

  UpdateUserUseCase(this._service);

  Future<Result<UserEntity, SafeAccountError>> call(
      RequestUpdateUser request) async {
    try {
      final response = await _service.updateUser(request);
      return Success(UserEntity.toEntityUpdate(response));
    } on SafeAccountError catch (e) {
      return Failure(e);
    }
  }
}
