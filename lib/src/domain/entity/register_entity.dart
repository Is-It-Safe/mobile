import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/entities/response/response_register.dart';

import '../../core/constants/string_constants.dart';

class RegisterEntity {
  String message;

  RegisterEntity({
    required this.message,
  });
  factory RegisterEntity.toEntity(ResponseRegister response) {
    return RegisterEntity(
      message: response.message ?? StringConstants.empty,
    );
  }
}
