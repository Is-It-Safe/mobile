import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeService(i.get<AuthService>())),
    Bind.lazySingleton((i) => GetBestRatedLocationsUseCase()),
    Bind.lazySingleton((i) => HomeBloc(
          getBestRatedLocationsUseCase: i.get<GetBestRatedLocationsUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
  ];
}
