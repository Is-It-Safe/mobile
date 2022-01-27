import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login_module/login_module.dart';
import 'package:is_it_safe_app/app/modules/on_boarding_module/on_boarding_module.dart';
import 'package:is_it_safe_app/app/modules/search_module/search_module.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'modules/splash_module/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];
  
  //TODO: Reverter para Splash após os testes da SearchModule

  /*
  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(kRouteOnBoarding, module: OnBoardingModule()),
    ModuleRoute(kRouteLogin, module: LoginModule()),
  ];*/

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SearchModule()),
  ];
}
