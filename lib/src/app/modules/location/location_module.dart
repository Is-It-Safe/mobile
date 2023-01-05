import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/bloc/location_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/location/presenter/pages/location_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/presenter/pages/review_page.dart';
import 'package:is_it_safe_app/src/app/modules/location/review/review_module.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_locations_by_id_use_case.dart';

class LocationModule extends Module {
  static const route = '/location';
  @override
  final List<Bind> binds = [
    Bind((i) => GetLocationsByIdUseCase()),
    Bind((i) => LocationBloC(
          getLocationsByIdUseCase: i.get<GetLocationsByIdUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    //ModuleRoute(Modular.initialRoute, module: LocationModule()),
    ChildRoute('/location-page',
        child: (_, args) =>
            LocationPage(location: (args.data as LocationEntity))),
    ModuleRoute(ReviewPage.route, module: ReviewModule()),
  ];
}
