import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/terms_and_conditions_page.dart';

class TermsAndConditionsModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const TermsAndConditionsPage(),
    ),
  ];
}
