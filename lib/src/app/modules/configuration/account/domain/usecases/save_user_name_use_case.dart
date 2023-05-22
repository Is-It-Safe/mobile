import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserNameUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserNameUseCase(this.sharedPreferences);

  Future<void> call(String value) async {
    sharedPreferences.saveUserName(value);
  }
}
