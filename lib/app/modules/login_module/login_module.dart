import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/login_service.dart';

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
  ];
}