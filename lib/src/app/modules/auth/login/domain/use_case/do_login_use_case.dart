import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_login.dart';

class DoLoginUseCase extends SafeUseCase {
  late final IAuthService _service;

  DoLoginUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<LoginEntity> call({
    required String username,
    required String password,
  }) async {
    final request = RequestLogin(
      username: username,
      password: password,
    );

    final _response = await _service.doLogin(request);

    return _parseResponseToEntity(_response);
  }

  LoginEntity _parseResponseToEntity(ResponseLogin response) {
    return LoginEntity(
      accessToken: response.accessToken ?? StringConstants.empty,
      refreshToken: response.refreshToken ?? StringConstants.empty,
      scope: response.scope ?? StringConstants.empty,
      tokenType: response.tokenType ?? StringConstants.empty,
      userFirstName: response.userFirstName ?? StringConstants.empty,
      expiresIn: response.expiresIn ?? IntConstants.empty,
      userId: response.userId ?? IntConstants.empty,
    );
  }
}
