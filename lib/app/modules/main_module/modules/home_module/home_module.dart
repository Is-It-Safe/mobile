import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/home_module/modules/contact_module/contact_module.dart';
import 'package:is_it_safe_app/core/data/service/home_service.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'home_bloc.dart';
import 'home_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeBloc()),
    Bind.lazySingleton((i) => HomeService())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomeWidget(),
      children: [
        ModuleRoute(kRouteContact, module: ContactModule()),
      ],
    ),
  ];
}
