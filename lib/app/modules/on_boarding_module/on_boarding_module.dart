import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login_module/login_module.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'on_boarding_bloc.dart';
import 'on_boarding_widget.dart';

class OnBoardingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OnBoardingBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const OnBoardingWidget()),
    ModuleRoute(kRouteLogin, module: LoginModule()),
  ];
}