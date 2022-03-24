import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/main_bloc.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'main_widget.dart';
import 'modules/home_module/home_module.dart';
import 'modules/profile_module/profile_module.dart';
import 'modules/search_module/search_module.dart';

class MainModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MainBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const BottomNavBar(),
      children: [
        ModuleRoute(kRouteHome, module: HomeModule()),
        ModuleRoute(kRouteSearch, module: SearchModule()),
        ModuleRoute(kRouteProfile, module: ProfileModule())
      ],
    ),
  ];
}
