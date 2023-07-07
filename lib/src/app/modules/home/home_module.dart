import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/terms_and_conditions_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_best_rated_locations_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_locations_near_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/services/home_services.dart';
import 'package:is_it_safe_app/src/app/modules/home/services/home_services_interface.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_user_location_permission_usecase.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service.dart';
import 'package:is_it_safe_app/src/components/location/safe_locator_impl.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_image_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/get_user_location_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/domain/usecases/get_user_name_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_user_location_permission_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/usecases/save_user_location_use_case.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => LocationService(
        i.get<AuthService>(),
      ),
    ),
    Bind.lazySingleton<HomeServicesInterface>(
      (i) => HomeServices(
        i.get<AuthService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => ProfileService(
        i.get<AuthService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetBestRatedLocationsUseCase(
        i.get<HomeServicesInterface>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetLocationsNearUser(
        i.get<HomeServicesInterface>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => SaveUserLocationTokenUseCase(),
    ),
    Bind.lazySingleton(
      (i) => GetUserLocationTokenUseCase(
        i.get<ISharedPreferencesService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => SaveUserLocationPermissionFirstSettingsUseCase(),
    ),
    Bind.lazySingleton(
      (i) => GetUserLocationPermissionUseCase(
        i.get<ISharedPreferencesService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => SafeLocatorImpl(),
    ),
    Bind.lazySingleton(
      (i) => GetUserNameUseCase(
        i.get<ISharedPreferencesService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => GetUserImageUseCase(
        i.get<ISharedPreferencesService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => HomeBloc(
        getLocationsNearUserUsecase: i.get<GetLocationsNearUser>(),
        getBestRatedLocationsUseCase: i.get<GetBestRatedLocationsUseCase>(),
        safeLocator: i.get<SafeLocatorImpl>(),
        getUserNameUseCase: i.get<GetUserNameUseCase>(),
        getUserImageUseCase: i.get<GetUserImageUseCase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
    ModuleRoute(
      TermsAndConditionsPage.route,
      module: TermsAndConditionsModule(),
    ),
  ];
}
