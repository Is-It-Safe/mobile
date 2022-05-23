import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/my_account_module/my_account_bloc.dart';
import './my_account_page.dart';

class MyAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MyAccountBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const MyAccountPage()),
  ];
}
