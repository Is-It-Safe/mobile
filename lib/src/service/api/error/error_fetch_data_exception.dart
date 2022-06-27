import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/service/api/error/error_exceptions.dart';

class FetchDataException extends ErrorExceptions {
  FetchDataException(String? error) : super(error, StringConstants.empty);
}
