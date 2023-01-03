import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_register.dart';

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
