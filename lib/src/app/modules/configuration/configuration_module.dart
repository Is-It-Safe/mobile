import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/terms_and_conditions_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/account_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/edit_account_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/presenter/pages/edit_account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/contact_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/contact/presenter/pages/contact_page.dart';

class ConfigurationModule extends Module {
  static const route = '/config';

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(AccountPage.route, module: AccountModule()),
    ModuleRoute(ContactPage.route, module: ContactModule()),
    ModuleRoute(EditAccountPage.route, module: EditAccountModule()),
    ModuleRoute(TermsAndConditionsPage.route,
        module: TermsAndConditionsModule()),
  ];
}
