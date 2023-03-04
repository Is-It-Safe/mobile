import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:result_dart/result_dart.dart';

class DoRegisterUseCase extends SafeUseCase {
  late final IAuthService service;

  DoRegisterUseCase(this.service);

  Future<Result<RegisterEntity, SafeAuthError>> call({
    required String profilePhoto,
    required String name,
    required String birthDate,
    required String username,
    required String email,
    required String password,
    required String pronoun,
    required int? gender,
    required int? sexualOrientation,
  }) async {
    final request = RequestRegister(
      photoUrl: profilePhoto,
      name: name.trim(),
      birthDate: birthDate,
      nickname: username.trim(),
      email: email.trim(),
      password: password.trim(),
      pronoun: pronoun.trim(),
      genderId: gender ?? 11,
      sexualOrientationId: sexualOrientation ?? 8,
    );

    if (name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty) {
      return Failure(
        SafeInvalidCredentialsError(
          "Campos de autenticação não podem estar vazios.",
        ),
      );
    }

    try {
      final response = await service.doRegister(request);

      return Success(RegisterEntity.toEntity(response));
    } on SafeAuthError catch (e) {
      return Failure(e);
    }
  }
}
