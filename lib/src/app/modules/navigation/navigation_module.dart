import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/home_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/bloc/navigation_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/pages/profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/profile_module.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/pages/search_page.dart';
import 'package:is_it_safe_app/src/app/modules/search/search_module.dart';

class NavigationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NavigationBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const NavigationPage(),
      children: [
        ModuleRoute(HomePage.route, module: HomeModule()),
        ModuleRoute(SearchPage.route, module: SearchModule()),
        ModuleRoute(ProfilePage.route, module: ProfileModule()),
      ],
    ),
  ];
}
