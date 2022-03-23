import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/app/modules/main_module/modules/contact_module/contact_bloc.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/contact_module/contact_widget.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/home_module/home_module.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

class ContactModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ContactBloc())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ContactWidget()
    ),
    ModuleRoute(kRouteHome, module: HomeModule())
  ];
}