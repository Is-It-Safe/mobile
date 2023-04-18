import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:result_dart/result_dart.dart';

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
