import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login_module/login_module.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/my_account_module.dart';
import 'package:is_it_safe_app/app/modules/on_boarding_module/on_boarding_module.dart';
import 'package:is_it_safe_app/app/modules/splash_module/splash_module.dart';
import 'package:is_it_safe_app/app/modules/terms_of_use_module/terms_of_use_module.dart';
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
    ModuleRoute(kRouteTermsOfUse, module: TermsOfUseModule()),
    ModuleRoute(kRouteMyAccount, module: MyAccountModule()),
  ];
}
