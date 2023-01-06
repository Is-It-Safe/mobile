import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/auth_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/configuration_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/location_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/navigation_module.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_name_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => SaveUserRefreshTokenUseCase()),
    Bind.lazySingleton((i) => DoLoginUseCase()),
    Bind.lazySingleton((i) => SaveUserTokenUseCase()),
    Bind.lazySingleton((i) => SaveUserLoginUseCase()),
    Bind.lazySingleton((i) => SaveUserImageUseCase()),
    Bind.lazySingleton((i) => SaveUserNameUseCase()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute(NavigationPage.route, module: NavigationModule()),
    ModuleRoute(ConfigurationModule.route, module: ConfigurationModule()),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
    ModuleRoute(SaveLocationPage.route, module: LocationModule()),
  ];
}
