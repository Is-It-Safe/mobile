import 'package:geocoding/geocoding.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserLocationTokenUseCase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserLocationTokenUseCase(this.sharedPreferences);

  Future<Placemark> call() async {
    return await sharedPreferences.readPlace();
  }
}
