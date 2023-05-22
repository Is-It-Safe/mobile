import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:result_dart/result_dart.dart';

class IsEmailAvailableUseCase extends SafeUseCase {
  final IAuthService service;

  IsEmailAvailableUseCase(this.service);

  Future<Result<bool, SafeAuthError>> call({
    required String email,
  }) async {
    if (email.isEmpty) {
      return Failure(
        SafeInvalidCredentialsError(
          "Campos de e-mail não pode estar vazio!",
        ),
      );
    }

    try {
      final response = await service.isEmailAvailable(email);
      return Success(!response);
    } on SafeAuthError catch (e) {
      throw Failure(e);
    }
  }
}
