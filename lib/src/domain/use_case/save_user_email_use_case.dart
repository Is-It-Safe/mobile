import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class SaveUserEmailUsecase extends SafeUseCase {
  final ISharedPreferencesService sharedPreferences;

  SaveUserEmailUsecase(this.sharedPreferences);

  Future<void> call({required String userEmail}) async {
    await sharedPreferences.saveUserEmail(userEmail: userEmail);
  }
}
