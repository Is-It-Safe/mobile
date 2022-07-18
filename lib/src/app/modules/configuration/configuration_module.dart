import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/account_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';

class ConfigurationModule extends Module {
  static const route = '/config';

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AccountPage.route, module: AccountModule()),
  ];
}