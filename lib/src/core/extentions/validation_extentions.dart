import 'package:is_it_safe_app/src/core/constants/regex_constants.dart';

extension SafeValidation on String {
  /// Retorna true caso a String seja um e-mail válido.
  bool isEmail() => contains(RegExp(RegexConstants.emailRegex as String));

  /// Retorna true caso a String seja uma senha válida.
  bool isPassword() => contains(
        RegExp(RegexConstants.passwordRegex as String),
      );

  bool isName() => !isEmpty;

  bool isDate() {
    final value = this;
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
}
