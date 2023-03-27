import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/bloc/register_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/register_profile_picture_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => AuthService(i())),
    Bind.lazySingleton((i) => GetSexualOrientationsUseCase(i())),
    Bind.lazySingleton((i) => GetGendersUseCase(i())),
    Bind.lazySingleton((i) => DoRegisterUseCase(i())),
    Bind.lazySingleton((i) => RegisterBloc(
          store: i(),
        )),
    Bind.lazySingleton((i) => RegisterProfileBloc(
          store: i(),
          doRegisterUseCase: i(),
          getGendersUseCase: i(),
          getSexualOrientationsUseCase: i(),
        )),
    Bind.lazySingleton((i) => RegisterProfilePictureBloc(
          store: i(),
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
      RegisterProfilePicturePage.route,
      child: (context, args) => const RegisterProfilePicturePage(),
    ),
    ChildRoute(
      TermsAndConditionsPage.route,
      child: (context, args) => const TermsAndConditionsPage(),
    ),
  ];
}
