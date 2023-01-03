import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/l10n/l10n.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';

class DeleteUserUseCase extends SafeUseCase {
  late final IProfileService _service;

  DeleteUserUseCase() {
    _service = Modular.get<ProfileService>();
  }

  Future<String> call({
    required int idUser,
  }) async {
    final response = await _service.deleteUser(idUser: idUser);
    return response.message ?? S.current.textDeleteUser;
  }
}
