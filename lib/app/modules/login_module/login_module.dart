import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/register_module/register_module.dart';
import 'package:is_it_safe_app/core/data/service/login/login.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'login_bloc.dart';
import 'login_widget.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginBloc(service: LoginService(), customSharedPreferences: CustomSharedPreferences())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const LoginWidget()),
    ModuleRoute(kRouteRegister, module: RegisterModule()),
  ];
}
