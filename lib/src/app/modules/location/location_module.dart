import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';

import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';

import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';


class LocationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GetLocationsByIdUseCase()),
    Bind.lazySingleton((i) => LocationBloC(
          getLocationsByIdUseCase: i.get<GetLocationsByIdUseCase>(),
        )),
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SaveLocationUseCase()),
    Bind.lazySingleton(
      (i) => SaveLocationBloc(
        saveLocationUseCase: i.get<SaveLocationUseCase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/location-page',
        child: (_, args) =>
            LocationPage(location: (args.data as LocationEntity))),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
    ChildRoute(
      '/save-location',
      child: (context, args) => const SaveLocationPage(),
    ),
  ];
}
