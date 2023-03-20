import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:result_dart/result_dart.dart';

class GetUserUseCase extends SafeUseCase {
  final IProfileService _service;

  GetUserUseCase(this._service);

  Future<Result<UserEntity, SafeProfileError>> call() async {
    try {
      final response = await _service.getUser();
      return Success(UserEntity.toEntity(response));
    } on SafeProfileError catch (e) {
      return Failure(e);
    }
  }
}
