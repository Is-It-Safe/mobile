import 'package:is_it_safe_app/src/core/constants/regex_constants.dart';

/// A classe [ValidationUtil] é responsável por gerenciar os métodos de validação utilizados no projeto.
/// **OBS:** Todos os métodos devem retornar um **bool**.
class ValidationUtil {
  /// Método responsável por validar um nome.
  @Deprecated('Use .isName() instead')
  static bool name(String name) {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  /// Método responsável por validar uma data.
  @Deprecated('Use .isDate() instead')
  static bool date(value) {
    if (value.length == 10) {
      int day = int.parse(
        value.substring(0, 2),
      );
      int month = int.parse(
        value.substring(3, 5),
      );
      int year = int.parse(
        value.substring(6, 10),
      );

      if (day < 1 || day > 31) return false;
      if (month < 1 || month > 12) return false;
      if (year < 1910 || year > 2003) return false;
    }

    return true;
  }

  /// Método responsável por validar um E-mail.
  @Deprecated('Use .isEmail() instead')
  static bool email(String value) {
    RegExp regex = RegExp(RegexConstants.emailRegex as String);
    return regex.hasMatch(value.trim());
  }

  /// Método responsável por validar uma senha.
  @Deprecated('Use .isPassword() instead')
  static bool passoword(String value) {
    RegExp regex = RegExp(RegexConstants.passwordRegex as String);
    return regex.hasMatch(value.trim());
  }
}
