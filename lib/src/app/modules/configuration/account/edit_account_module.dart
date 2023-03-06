import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/edit_account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/edit_account_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/update_user_use_case.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class EditAccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => ApiService()),
    Bind.lazySingleton((i) => AuthService(i.get<ApiService>())),
    Bind.lazySingleton((i) => ProfileService(i.get<AuthService>())),
    Bind.lazySingleton((i) => SaveUserLoginUseCase()),
    Bind.lazySingleton((i) => GetUserUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => GetGendersUseCase(i.get<AuthService>())),
    Bind.lazySingleton(
        (i) => GetSexualOrientationsUseCase(i.get<AuthService>())),
    Bind.lazySingleton((i) => UpdateUserUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => EditAccountBloc(
          getUserUseCase: i.get<GetUserUseCase>(),
          saveUserLoginUseCase: i.get<SaveUserLoginUseCase>(),
          getGendersUseCase: i.get<GetGendersUseCase>(),
          getSexualOrientationsUseCase: i.get<GetSexualOrientationsUseCase>(),
          updateUserUseCase: i.get<UpdateUserUseCase>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const EditAccountPage(),
    ),
  ];
}
