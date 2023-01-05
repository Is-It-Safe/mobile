import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/login_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/on_boarding_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/on_boarding/presenter/pages/on_boarding_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/register_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/splash/splash_module.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<RegisterStore>((i) => RegisterStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(OnBoardingPage.route, module: OnBoardingModule()),
    ModuleRoute(LoginPage.route, module: LoginModule()),
    ModuleRoute(RegisterPage.route, module: RegisterModule()),
  ];
}
