import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/add_location/presenter/bloc/add_locale_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/add_location/presenter/pages/add_locale_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';

class LocationModule extends Module {
  static const route = '/location';
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SaveLocationUseCase()),
    Bind.lazySingleton((i) => AddLocaleBloc(
          saveLocationUseCase: i.get<SaveLocationUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    // ModuleRoute(Modular.initialRoute, module: LocationModule()),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const AddLocalePage(),
    ),
  ];
}
