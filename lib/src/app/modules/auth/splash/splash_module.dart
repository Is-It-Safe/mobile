import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/domain/use_case/get_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/domain/use_case/get_user_on_boarding_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/presenter/bloc/splash_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/presenter/pages/splash_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/home_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => GetUserLoginUseCase()),
    Bind.lazySingleton((i) => GetUserOnBoaringUseCase()),
    Bind.lazySingleton((i) => SplashBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SplashPage(),
    ),
    ModuleRoute(HomePage.route, module: HomeModule()),
  ];
}
