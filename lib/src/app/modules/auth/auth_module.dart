import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/login_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/on_boarding/on_boarding_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/on_boarding/presenter/pages/on_boarding_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/register_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/splash/splash_module.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthService(i.get<ApiService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(OnBoardingPage.route, module: OnBoardingModule()),
    ModuleRoute(LoginPage.route, module: LoginModule()),
    ModuleRoute(RegisterPage.route, module: RegisterModule()),
  ];
}
