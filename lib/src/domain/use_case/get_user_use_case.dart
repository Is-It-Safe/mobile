import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:result_dart/result_dart.dart';

import '../../app/modules/profile/error/safe_profile_error.dart';

class GetUserUseCase extends SafeUseCase {
  final IProfileService service;

  GetUserUseCase(this.service);

  Future<Result<UserEntity, SafeProfileError>> call() async {
    try {
      final response = await service.getUser();
      return Success(UserEntity.toEntity(response));
    } on SafeProfileError catch (e) {
      return Failure(e);
    }
  }
}
