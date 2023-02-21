import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserOnBoaringUseCase implements SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserOnBoaringUseCase(this.sharedPreferences);

  Future<bool> call() async {
    try {
      final response = await sharedPreferences.readOnBoarding();
      return response;
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
    return false;
  }
}
