import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';
import 'package:result_dart/result_dart.dart';

class GetUserLoginUseCase implements SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserLoginUseCase(this.sharedPreferences);

  Future<Result<bool, SafeAuthError>> call() async {
    try {
      final response = await sharedPreferences.readLogin();
      return Success(response);
    } on SafeAuthError catch (e) {
      SafeLogUtil.instance.logError(e);
      return Failure(e);
    }
  }
}
