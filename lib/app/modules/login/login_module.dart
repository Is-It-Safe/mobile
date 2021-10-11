import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/login/login_widget.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const LoginWidget()),
  ];
}
