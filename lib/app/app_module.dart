import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_module.dart';

import 'modules/splash_module/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    //TODO: Reverter para Splash após os testes da HomeModule
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
