import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';

class GetSexualOrientationsUseCase extends SafeUseCase {
  late final IAuthService _service;

  GetSexualOrientationsUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<List<SexualOrientationEntity>> call() async {
    final response = await _service.getSexualOrientations();

    return response.map((e) => SexualOrientationEntity.toEntity(e)).toList();
  }
}
