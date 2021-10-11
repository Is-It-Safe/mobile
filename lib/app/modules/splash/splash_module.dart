import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login/login_module.dart';
import 'package:is_it_safe_app/app/modules/onBoarding/on_boarding_module.dart';
import 'package:is_it_safe_app/app/modules/splash/splash_widget.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashWidget()),
    ModuleRoute(kRouteLogin, module: LoginModule()),
    ModuleRoute(kRouteOnBoarding, module: OnBoardingModule()),
  ];
}
