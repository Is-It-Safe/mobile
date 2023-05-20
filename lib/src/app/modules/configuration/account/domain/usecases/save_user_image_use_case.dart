import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserImageUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserImageUseCase(this.sharedPreferences);

  Future<void> call(String value) async {
    sharedPreferences.saveUserImage(value);
  }
}
