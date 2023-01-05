import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserLocationPermissionFirstSettingsUseCase extends SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  GetUserLocationPermissionFirstSettingsUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  Future<bool> call() async {
    return await _sharedPreferences.readLocationPermission();
  }
}
