import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserLocationPermissionUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserLocationPermissionUseCase(this.sharedPreferences);

  Future<bool> call() async {
    return await sharedPreferences.readLocationPermission();
  }
}
