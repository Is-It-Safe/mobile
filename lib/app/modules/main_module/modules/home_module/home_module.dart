import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/home/home.dart';

import 'home_bloc.dart';
import 'home_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeBloc(service: HomeService())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const HomeWidget()),
  ];
}
