import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';

class DoLoginUseCase extends SafeUseCase {
  late final IAuthService _service;

  DoLoginUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<LoginEntity> call({
    required String email,
    required String password,
  }) async {
    final request = RequestLogin(
      email: email,
      password: password,
    );

    final response = await _service.doLogin(request);

    return LoginEntity.toEntity(response);
  }
}
