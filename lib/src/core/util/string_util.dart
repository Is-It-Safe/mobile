import 'package:is_it_safe_app/src/core/constants/regex_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

/// A classe [StringUtil] é responsável por gerenciar os métodos de utilidades de String utilizados no projeto.
/// **OBS:** Todos os métodos devem retornar uma **String**.
class StringUtil {
  ///Retorna o link dentro de um texto.
  static String getLinkFromText(String value) {
    RegExp regex = RegExp(RegexConstants.linkFromTextRegex as String);
    Iterable<RegExpMatch> matches = regex.allMatches(value);

    return value.substring(matches.first.start, matches.first.end);
  }

  static String getContactEmailSubject(String userName) {
    return '${StringConstants.contactEmailSubject}$userName';
  }

  static String getContactEmailUrl({
    required String userName,
    required String body,
  }) {
    final subject = getContactEmailSubject(userName);
    return 'mailto:${StringConstants.contactEmail}?subject=$subject&body=$body';
  }
}
