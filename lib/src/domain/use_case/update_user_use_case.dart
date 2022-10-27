import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/user_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';

class UpdateUserUseCase extends SafeUseCase {
  late final IProfileService _service;

  UpdateUserUseCase() {
    _service = Modular.get<ProfileService>();
  }

  Future<UserEntity> call(int id) async {
    final _response = await _service.updateUser(id);

    return UserEntity.toEntityUpdate(_response);
  }
}
