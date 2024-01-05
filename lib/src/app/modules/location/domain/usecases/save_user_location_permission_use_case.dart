import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserLocationPermissionUseCase extends SafeUseCase {
  late final ISharedPreferencesService sharedPreferences;

  SaveUserLocationPermissionUseCase(this.sharedPreferences);

  Future<void> call(bool value) async {
    sharedPreferences.saveLocationPermission(value);
  }
}
