import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/bloc/login_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/home/home_module.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/navigation_module.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_name_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => ApiService()),
    Bind.lazySingleton((i) => AuthService(i.get<ApiService>())),
    Bind.lazySingleton((i) => LoginBloc(
          doLoginUseCase: i.get<DoLoginUseCase>(),
          saveUserLoginUseCase: i.get<SaveUserLoginUseCase>(),
          saveUserTokenUseCase: i.get<SaveUserTokenUseCase>(),
          saveUserRefreshTokenUseCase: i.get<SaveUserRefreshTokenUseCase>(),
          saveUserImageUseCase: i.get<SaveUserImageUseCase>(),
          saveUserNameUseCase: i.get<SaveUserNameUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const LoginPage(),
    ),
    ModuleRoute(NavigationPage.route, module: NavigationModule()),
    ModuleRoute(HomePage.route, module: HomeModule()),
  ];
}
