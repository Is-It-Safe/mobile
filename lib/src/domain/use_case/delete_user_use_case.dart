// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';

import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';

import '../../../generated/l10n.dart';

class DeleteUserUseCase extends SafeUseCase {
  late final IProfileService _service;

  DeleteUserUseCase() {
    _service = Modular.get<ProfileService>();
  }

  Future<String> call({
    required int idUser,
  }) async {
    final response = await _service.deleteUser(idUser);
    return response.message ?? S.current.textDeleteUser;
  }
}
