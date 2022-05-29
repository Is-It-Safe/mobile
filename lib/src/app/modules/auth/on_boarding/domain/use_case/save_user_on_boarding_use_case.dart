import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserOnBoardingUseCase extends SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  SaveUserOnBoardingUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  Future<void> call(bool value) async {
    _sharedPreferences.saveOnBoarding(value);
  }
}
