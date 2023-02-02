import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_login.dart';
import 'package:result_dart/result_dart.dart';

class DoLoginUseCase extends SafeUseCase {
  final IAuthService service;

  DoLoginUseCase(this.service);

  Future<Result<LoginEntity, SafeAuthError>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return Failure(SafeInvalidCredentialsError(
          "Campos de autenticação não podem estar vazios!"));
    }

    try {
      final request = RequestLogin(
        email: email,
        password: password,
        grantType: ApiConstants.kGrantTypePassword,
      );
      print(request.email);
      print(request.password);
      print(request.grantType);
      final response = await service.doLogin(request);

      return Success(LoginEntity.toEntity(response));
    } on SafeAuthError catch (e) {
      throw Failure(e);
    }
  }
}
