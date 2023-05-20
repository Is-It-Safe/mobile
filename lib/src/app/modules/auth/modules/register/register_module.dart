import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/do_register_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/usecases/is_email_available_use_case%20copy.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/usecases/is_username_available_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_profile_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/bloc/register_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_profile_picture_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore()),
    Bind.lazySingleton((i) => IsUsernameAvailableUseCase(i())),
    Bind.lazySingleton((i) => IsEmailAvailableUseCase(i())),
    Bind.lazySingleton((i) => GetSexualOrientationsUseCase(i())),
    Bind.lazySingleton((i) => GetGendersUseCase(i())),
    Bind.lazySingleton((i) => DoRegisterUseCase(i())),
    Bind.lazySingleton((i) => RegisterBloc(
          store: i(),
          isUsernameAvailableUseCase: i(),
          isEmailAvailableUseCase: i(),
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
