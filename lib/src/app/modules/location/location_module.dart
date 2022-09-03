import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';

class LocationModule extends Module {
  static const route = '/location';
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    //ModuleRoute(Modular.initialRoute, module: LocationModule()),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
  ];
}
