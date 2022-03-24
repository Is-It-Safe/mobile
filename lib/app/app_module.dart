import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/contact_module/contact_module.dart';
import 'package:is_it_safe_app/app/modules/login_module/login_module.dart';
import 'package:is_it_safe_app/app/modules/on_boarding_module/on_boarding_module.dart';
import 'package:is_it_safe_app/app/modules/splash_module/splash_module.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'modules/main_module/main_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(kRouteOnBoarding, module: OnBoardingModule()),
    ModuleRoute(kRouteLogin, module: LoginModule()),
    ModuleRoute(kRouteMain, module: MainModule()),
    ModuleRoute(kRouteContact, module: ContactModule())
  ];
}
