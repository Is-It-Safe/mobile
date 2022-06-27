import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_register.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';

class DoRegisterUseCase extends SafeUseCase {
  late final IAuthService _service;

  DoRegisterUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<RegisterEntity> call({
    required String profilePhoto,
    required String name,
    required String birthDate,
    required String username,
    required String email,
    required String password,
    required String pronoun,
    required String? gender,
    required String? sexualOrientation,
  }) async {
    final request = RequestRegister(
      photoUrl: profilePhoto,
      name: name.trim(),
      birthDate: birthDate,
      nickname: username.trim(),
      email: email.trim(),
      password: password.trim(),
      pronoun: pronoun.trim(),
      genderId: int.parse(gender ?? 11.toString()),
      sexualOrientationId: int.parse(sexualOrientation ?? 8.toString()),
    );

    final _response = await _service.doRegister(request);

    return _parseResponseToEntity(_response);
  }

  RegisterEntity _parseResponseToEntity(ResponseRegister response) {
    return RegisterEntity(
      message: response.message ?? StringConstants.empty,
    );
  }
}
