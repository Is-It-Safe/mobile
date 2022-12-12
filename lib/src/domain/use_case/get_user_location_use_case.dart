import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserLocationTokenUseCase extends SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  GetUserLocationTokenUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  Future<Placemark> call() async {
    return await _sharedPreferences.readPlace();
  }
}
