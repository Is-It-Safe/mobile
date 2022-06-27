import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

/// A classe [FormatterUtil] é responsável por gerenciar os métodos de utilidades de formatação utilizados no projeto.
class FormatterUtil {
  ///Formata a data que vem da API.
  static String dateFromAPI(String date) {
    var split = date.split(StringConstants.hyphen);
    return split[2] +
        StringConstants.slash +
        split[1] +
        StringConstants.slash +
        split[0];
  }
}
