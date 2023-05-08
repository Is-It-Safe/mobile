import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/request/resquest_update_user.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/models/user_entity.dart';

class UpdatePhotoUseCase extends SafeUseCase {
  late final IProfileService _service;

  UpdatePhotoUseCase() {
    _service = Modular.get<ProfileService>();
  }

  Future<UserEntity> call(RequestUpdateUser request) async {
    final _response = await _service.updateUser(request);

    return UserEntity.toEntityUpdate(_response);
  }
}
