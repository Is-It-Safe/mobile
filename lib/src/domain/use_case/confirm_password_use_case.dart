import 'package:flutter_modular/flutter_modular.dart';

import '../../core/interfaces/safe_use_case.dart';
import '../../service/api/modules/auth/auth_service.dart';
import '../../service/api/modules/auth/auth_service_interface.dart';
import '../../service/api/modules/auth/request/request_confirm_password.dart';

class ConfirmPasswordUseCase extends SafeUseCase {
  late final IAuthService _service;

  ConfirmPasswordUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<bool> call(RequestConfirmPassword password) async {
    final _response = await _service.confirmPassword(password);
    return _response;
  }
}
