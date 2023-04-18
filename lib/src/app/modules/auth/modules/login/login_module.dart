import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/home_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/navigation_module.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';

import 'presenter/bloc/login_bloc.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginBloc(
          doLoginUseCase: i(),
          saveUserLoginUseCase: i(),
          saveUserTokenUseCase: i(),
          saveUserRefreshTokenUseCase: i(),
          saveUserImageUseCase: i(),
          saveUserNameUseCase: i(),
          saveUserEmailUseCase: i(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const LoginPage(),
    ),
    ModuleRoute(NavigationPage.route, module: NavigationModule()),
    ModuleRoute(HomePage.route, module: HomeModule()),
  ];
}
