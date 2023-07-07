import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserLoginUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserLoginUseCase(this.sharedPreferences);

  Future<void> call(bool value) async {
    sharedPreferences.saveLogin(value);
  }
}
