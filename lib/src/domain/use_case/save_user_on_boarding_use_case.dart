import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserOnBoardingUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserOnBoardingUseCase(this.sharedPreferences);

  Future<void> call(bool value) async {
    sharedPreferences.saveOnBoarding(value);
  }
}
