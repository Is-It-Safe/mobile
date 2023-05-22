import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/location/services/location_service.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/usecases/delete_review_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/get_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/bloc/profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/pages/profile_page.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => ProfileService(i.get<AuthService>())),
    Bind.lazySingleton((i) => LocationService(i.get<AuthService>())),
    Bind.lazySingleton(
        (i) => SaveUserLoginUseCase(i.get<ISharedPreferencesService>())),
    Bind.lazySingleton((i) => GetUserUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => DeleteReviewUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => ProfileBloc(
          getUserUseCase: i.get<GetUserUseCase>(),
          saveUserLoginUseCase: i.get<SaveUserLoginUseCase>(),
          deleteReviewUseCase: i.get<DeleteReviewUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const ProfilePage(),
    ),
  ];
}
