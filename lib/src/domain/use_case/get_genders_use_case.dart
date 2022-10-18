import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';

class GetGendersUseCase extends SafeUseCase {
  late final IAuthService _service;

  GetGendersUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<List<GenderEntity>> call() async {
    final response = await _service.getGenders();

    return response.map((e) => GenderEntity.toEntity(e)).toList();
  }
}
