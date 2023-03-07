import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:result_dart/result_dart.dart';

class ChangePasswordUsecase implements SafeUseCase {
  final IAuthService service;

  ChangePasswordUsecase(this.service);

  Future<Result<dynamic, SafeAuthError>> call(
      {required String password}) async {
    if (password.isEmpty) {
      return Failure(
          SafeInvalidCredentialsError("A senha não pode estar vazia!"));
    }

    try {
      final response = await service.changePassword(password);
      return Success(response);
    } on SafeAuthError catch (e) {
      return Failure(e);
    }
  }
}
