import 'package:flutter_modular/flutter_modular.dart';
import '../auth/services/auth_service.dart';
import '../../../domain/use_case/get_locations_by_name_use_case.dart';
import 'presenter/bloc/search_bloc.dart';
import 'presenter/pages/search_page.dart';
import '../../../service/api/modules/search/search_service.dart';

import '../../../service/api/modules/location/location_service.dart';

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
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SearchPage(),
    ),
  ];
}
