import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/terms_of_use_module/terms_of_use_widget.dart';

class TermsOfUseModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const TermsOfUseWidget()),
  ];
}
