import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login_module/login_module.dart';
import 'package:is_it_safe_app/app/modules/on_boarding_module/on_boarding_module.dart';
import 'package:is_it_safe_app/app/modules/splash_module/splash_bloc.dart';
import 'package:is_it_safe_app/app/modules/splash_module/splash_widget.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => SplashBloc(sharedPreferences: SharedPreferencesService())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashWidget()),
    ModuleRoute(kRouteLogin, module: LoginModule()),
    ModuleRoute(kRouteOnBoarding, module: OnBoardingModule()),
  ];
}
