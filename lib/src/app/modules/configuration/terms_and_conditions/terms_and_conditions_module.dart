import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';

class TermsAndConditionsModule extends Module {
  static const route = '/terms';

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const TermsAndConditionsPage(),
    ),
  ];
}
