import 'package:is_it_safe_app/app/modules/home_module/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const HomeWidget()),
  ];
}
