import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_locations_by_id_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/save_location_page.dart';

import 'package:is_it_safe_app/src/app/modules/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/review/review_module.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';

import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_location_use_case.dart';

import '../profile/services/profile_service.dart';
import '../review/domain/usecases/save_review_use_case.dart';
import '../review/presenter/bloc/review_bloc.dart';
import 'domain/usecases/get_location_by_cep_use_case.dart';
import 'presenter/bloc/save_location_bloc.dart';

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
        )),
    Bind.lazySingleton(
        (i) => GetLocationByCepUseCase(i.get<LocationService>())),
    Bind.lazySingleton((i) => SaveLocationBloC(
          saveLocationUseCase: i.get<SaveLocationUseCase>(),
          getLocationsByCepUseCase: i.get<GetLocationByCepUseCase>(),
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
