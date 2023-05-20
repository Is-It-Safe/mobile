import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserEmailUsecase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  GetUserEmailUsecase(this.sharedPreferences);

  Future<String> call() async {
    return await sharedPreferences.getUserEmail();
  }
}
