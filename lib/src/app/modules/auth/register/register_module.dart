import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_picture_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/safe_profile_picture_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => AuthService()),
    Bind.lazySingleton((i) => GetSexualOrientationsUseCase()),
    Bind.lazySingleton((i) => GetGendersUseCase()),
    Bind.lazySingleton((i) => DoRegisterUseCase()),
    Bind.lazySingleton((i) => SafeProfilePictureBloC()),
    Bind.lazySingleton((i) => RegisterBloc(
          doRegisterUseCase: i.get<DoRegisterUseCase>(),
          getGendersUseCase: i.get<GetGendersUseCase>(),
          getSexualOrientationsUseCase: i.get<GetSexualOrientationsUseCase>(),
          profilePictureController: i.get<SafeProfilePictureBloC>(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const RegisterPage(),
    ),
    ChildRoute(
      RegisterProfilePage.route,
      child: (context, args) => const RegisterProfilePage(),
    ),
    ChildRoute(
      SafeProfilePicturePage.route,
      child: (context, args) => const SafeProfilePicturePage(),
    ),
  ];
}
