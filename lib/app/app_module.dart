import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/onBoarding/on_boarding_bloc.dart';
import 'package:is_it_safe_app/app/modules/splash/splash_module.dart';

import 'modules/login/login_bloc.dart';
import 'modules/splash/splash_bloc.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SplashBloc()),
    Bind.lazySingleton((i) => LoginBloc()),
    Bind.lazySingleton((i) => OnBoardingBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
  ];
}
