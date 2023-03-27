import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserNameUseCase implements SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserNameUseCase(this.sharedPreferences);

  Future<String> call() async {
    try {
      final response = await sharedPreferences.readUserName();
      return response;
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
    return StringConstants.empty;
  }
}
