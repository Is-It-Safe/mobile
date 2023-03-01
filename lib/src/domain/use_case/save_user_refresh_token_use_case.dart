import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserRefreshTokenUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserRefreshTokenUseCase(this.sharedPreferences);

  Future<void> call(String value) async {
    sharedPreferences.saveRefreshToken(value);
  }
}
