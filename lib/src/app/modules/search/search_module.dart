import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';
import '../../../core/state/safe_stream.dart';
import '../auth/services/auth_service.dart';
import '../location/domain/entities/location_entity.dart';
import '../location/domain/usecases/get_locations_by_name_use_case.dart';
import 'presenter/bloc/search_bloc.dart';
import 'presenter/pages/search_page.dart';
import 'services/search/search_service.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SearchService(i.get<AuthService>())),
    Bind.lazySingleton(
        (i) => GetLocationsByNameUseCase(i.get<SearchService>())),
    Bind.lazySingleton(
      (i) => SearchBloc(
        getLocationsByNameUseCase: i.get<GetLocationsByNameUseCase>(),
      ),
    ),
    Bind.lazySingleton((i) => SafeStream<LocationEntity?>(data: null)),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    ),
  ];
}
