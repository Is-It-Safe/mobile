import 'package:is_it_safe_app/src/core/constants/regex_constants.dart';

extension SafeValidation on String {
  /// Retorna true caso a String seja um e-mail válido.
  bool isEmail() => contains(RegExp(RegexConstants.emailRegex as String));

  /// Retorna true caso a String seja uma senha válida.
  bool isValidPassword() =>
      contains(RegExp(RegexConstants.passwordRegex as String));
}
