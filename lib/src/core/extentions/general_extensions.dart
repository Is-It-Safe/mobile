import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

extension GeneralExtentions<T> on T? {
  /// Retorna o valor do objeto se não for nulo. Caso contrário, retorna o valor default.
  T get orDefault {
    final value = this;
    if (value == null) {
      return {
        int: IntConstants.empty,
        double: DoubleConstants.empty,
        String: StringConstants.empty,
        bool: false,
        List: [],
        Map: {},
      }[T] as T;
    }
    return value;
  }
}
