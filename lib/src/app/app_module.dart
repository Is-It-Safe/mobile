import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/auth_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/home_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => SharedPreferencesService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute(HomePage.route, module: HomeModule())
    // ModuleRoute(kRouteOnBoarding, module: OnBoardingModule()),
    // ModuleRoute(kRouteLogin, module: LoginModule()),
    // ModuleRoute(kRouteMain, module: MainModule()),
    // ModuleRoute(kRouteTermsOfUse, module: TermsOfUseModule()),
    // ModuleRoute(kRouteMyAccount, module: MyAccountModule()),
  ];
}
