import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class GetUserOnBoaringUseCase implements SafeUseCase {
  late final ISharedPreferencesService _sharedPreferences;

  GetUserOnBoaringUseCase() {
    _sharedPreferences = Modular.get<SharedPreferencesService>();
  }

  Future<bool> call() async {
    try {
      final _response = await _sharedPreferences.readOnBoarding();
      return _response;
    } catch (e) {
      LogUtil().error(e.toString());
    }
    return false;
  }
}
