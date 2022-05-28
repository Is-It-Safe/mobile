import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserLoginUseCase implements SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  GetUserLoginUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  @override
  Future<bool> call() async {
    final _response = await _sharedPreferences.readLogin();
    return _response;
  }
}
