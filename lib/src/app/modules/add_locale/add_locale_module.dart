import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/add_locale/presenter/bloc/add_locale_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/add_locale/presenter/pages/add_locale_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';

import '../../../service/api/modules/add_location/add_location_service.dart';

class AddLocaleModule extends Module {
  @override
  final List<Bind> binds = List.from([
    Bind(
      (i) => AddLocationService(
        i.get<AuthService>(),
      ),
    ),
    Bind(
      (i) => SaveLocationUseCase(),
    ),
    Bind(
      (i) => AddLocaleBloc(
        saveLocationUseCase: i(),
      ),
    ),
  ]);

  @override
  final List<ModularRoute> routes = List.from(
    [
      ChildRoute(
        Modular.initialRoute,
        child: (context, args) => const AddLocalePage(),
      )
    ],
  );
}
