import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/components/location/safe_locator.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_location_use_Case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_location_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton((i) => ProfileService(i.get<AuthService>())),
    Bind.lazySingleton((i) => GetBestRatedLocationsUseCase()),
    Bind.lazySingleton((i) => SaveUserLocationTokenUseCase()),
    Bind.lazySingleton((i) => GetUserLocationTokenUseCase()),
    Bind.lazySingleton((i) => SafeLocator()),
    Bind.lazySingleton(
      (i) => HomeBloc(
        getBestRatedLocationsUseCase: i.get<GetBestRatedLocationsUseCase>(),
        getUserLocationTokenUseCase: i.get<GetUserLocationTokenUseCase>(),
        saveUserLocationTokenUseCase: i.get<SaveUserLocationTokenUseCase>(),
        locator: i.get<SafeLocator>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
  ];
}
