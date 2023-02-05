import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:result_dart/result_dart.dart';

import '../../core/interfaces/safe_use_case.dart';
import '../../service/api/modules/auth/auth_service_interface.dart';
import '../../service/api/modules/auth/request/request_confirm_password.dart';

class ConfirmPasswordUseCase extends SafeUseCase {
  final IAuthService service;

  ConfirmPasswordUseCase(this.service);

  Future<Result<bool, SafeAuthError>> call(
      RequestConfirmPassword password) async {
    if (password.password.isEmpty) {
      return Failure(
          SafeInvalidCredentialsError("A senha não pode estar vazia!"));
    }

    try {
      final response = await service.confirmPassword(password);
      return Success(response);
    } on SafeAuthError catch (e) {
      return Failure(e);
    }
  }
}
