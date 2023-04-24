import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_locations_by_id_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/save_location_page.dart';

import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';

import 'package:is_it_safe_app/src/domain/use_case/save_location_use_case.dart';

class LocationModule extends Module {
  static String get route => "/location";

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SaveLocationUseCase(i.get<LocationService>())),
    Bind.lazySingleton(
        (i) => GetLocationsByIdUseCase(i.get<LocationService>())),
    Bind.lazySingleton((i) => LocationBloC(
          getLocationsByIdUseCase: i.get<GetLocationsByIdUseCase>(),
          saveLocationUseCase: i.get<SaveLocationUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      LocationPage.route,
      child: (_, args) => LocationPage(location: (args.data as LocationEntity)),
    ),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
    ChildRoute(
      SaveLocationPage.route,
      child: (context, args) => const SaveLocationPage(),
    ),
  ];
}
