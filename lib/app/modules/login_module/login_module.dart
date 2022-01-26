import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_module.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_module.dart';
import 'package:is_it_safe_app/core/data/service/login_service.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'login_bloc.dart';
import 'login_widget.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginBloc()),
    Bind.lazySingleton((i) => LoginService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const LoginWidget()),
    ModuleRoute(kRouteHome, module: HomeModule()),
    ModuleRoute(kRouteRegister, module: RegisterModule()),
  ];
}
