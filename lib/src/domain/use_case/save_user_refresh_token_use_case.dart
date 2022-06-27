import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserRefreshTokenUseCase extends SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  SaveUserRefreshTokenUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  Future<void> call(String value) async {
    _sharedPreferences.saveRefreshToken(value);
  }
}
