import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/bloc/login_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => SaveUserLoginUseCase()),
    Bind.lazySingleton((i) => SaveUserTokenUseCase()),
    Bind.lazySingleton((i) => SaveUserRefreshTokenUseCase()),
    Bind.lazySingleton((i) => DoLoginUseCase()),
    Bind.lazySingleton((i) => LoginBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const LoginPage(),
    ),
  ];
}
