import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/change_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/get_user_email_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_email_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/edit_account_module.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/modules/edit_account_module/presenter/pages/edit_account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/account_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/bloc/change_password_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/change_email_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/change_password_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/get_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/update_user_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_picture/safe_profile_picture_page.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service_interface.dart';

import 'presenter/bloc/change_email_bloc.dart';
import 'presenter/pages/deactivate_account_page.dart';

class AccountModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ApiService()),
    Bind.lazySingleton((i) => AuthService(i.get<ApiService>())),
    Bind.lazySingleton((i) => SharedPreferencesService()),
    Bind.lazySingleton((i) => ProfileService(i.get<AuthService>())),
    Bind.lazySingleton(
        (i) => SaveUserLoginUseCase(i.get<ISharedPreferencesService>())),
    Bind.lazySingleton((i) => GetUserUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => UpdateUserUseCase(i.get<ProfileService>())),
    Bind.lazySingleton((i) => SafeProfilePictureBloC()),
    Bind.lazySingleton((i) => ConfirmPasswordUseCase(i.get<AuthService>())),
    Bind.lazySingleton((i) => ChangePasswordUsecase(i.get<AuthService>())),
    Bind.lazySingleton((i) => ChangePasswordBloC(
          confirmPasswordUseCase: i.get<ConfirmPasswordUseCase>(),
          changePasswordUsecase: i.get<ChangePasswordUsecase>(),
        )),
    Bind.lazySingleton(
        (i) => GlobalKey<ScaffoldState>(debugLabel: "key-password-confirm")),
    Bind.lazySingleton(
      (i) => AccountBloc(
        getUserUseCase: i.get<GetUserUseCase>(),
        updateUserUseCase: i.get<UpdateUserUseCase>(),
        saveUserLoginUseCase: i.get<SaveUserLoginUseCase>(),
        safeProfilePictureBloc: i.get<SafeProfilePictureBloC>(),
        saveUserImageUseCase: i.get<SaveUserImageUseCase>(),
      ),
    ),
    Bind((i) => GetUserEmailUsecase(i.get<ISharedPreferencesService>())),
    Bind((i) => SaveUserEmailUsecase(i.get<ISharedPreferencesService>())),
    Bind(
      (i) => ChangeEmailBloc(
        i.get<GetUserEmailUsecase>(),
        i.get<SaveUserEmailUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const AccountPage(),
    ),
    ChildRoute(
      SafeProfilePicturePage.route,
      child: (context, args) => const SafeProfilePicturePage(),
    ),
    ChildRoute(
      ChangePasswordPage.route,
      child: (context, args) => const ChangePasswordPage(),
    ),
    ChildRoute(
      ChangeEmailPage.route,
      child: (context, args) => const ChangeEmailPage(),
    ),
    ChildRoute(
      DeactivateAccountPage.route,
      child: (context, args) => const DeactivateAccountPage(),
    ),
    ModuleRoute(
      EditAccountPage.route,
      module: EditAccountModule(),
    ),
  ];
}
