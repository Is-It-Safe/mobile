import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:result_dart/result_dart.dart';

class IsUsernameAvailableUseCase extends SafeUseCase {
  final IAuthService service;

  IsUsernameAvailableUseCase(this.service);

  Future<Result<bool, SafeAuthError>> call({
    required String username,
  }) async {
    if (username.isEmpty) {
      return Failure(
        SafeInvalidCredentialsError(
          "Campos de username não pode estar vazio!",
        ),
      );
    }
    if (username.length < 3) {
      return Failure(
        SafeInvalidCredentialsError(
          "Username deve ter no mínimo 3 caracteres!",
        ),
      );
    }

    if (username.length > 25) {
      return Failure(
        SafeInvalidCredentialsError(
          "Username deve ter no máximo 25 caracteres!",
        ),
      );
    }

    try {
      final response = await service.isUsernameAvailable(username);
      return Success(response);
    } on SafeAuthError catch (e) {
      throw Failure(e);
    }
  }
}
