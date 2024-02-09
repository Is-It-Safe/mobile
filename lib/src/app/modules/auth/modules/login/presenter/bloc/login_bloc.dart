import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/domain/usecases/do_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_email_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/domain/usecases/save_user_name_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/pages/navigation_page.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/flavor_util.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginBloc extends SafeBloC {
  final DoLoginUseCase doLoginUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;
  final SaveUserRefreshTokenUseCase saveUserRefreshTokenUseCase;
  final SaveUserImageUseCase saveUserImageUseCase;
  final SaveUserNameUseCase saveUserNameUseCase;
  final SaveUserEmailUsecase saveUserEmailUseCase;

  final isLoginEnabled = SafeStream<bool>(data: false);
  final loginEntityStream = SafeStream<LoginEntity?>(data: null);
  final isPassowordVisible = SafeStream<bool>(data: false);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc({
    required this.doLoginUseCase,
    required this.saveUserLoginUseCase,
    required this.saveUserTokenUseCase,
    required this.saveUserRefreshTokenUseCase,
    required this.saveUserImageUseCase,
    required this.saveUserNameUseCase,
    required this.saveUserEmailUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  void navigateToHome() {
    Modular.to.pushNamedAndRemoveUntil(
      NavigationPage.route + HomePage.route,
      (r) => false,
    );
  }

  Future<void> doLogin() async {
    loginEntityStream.loading();
    try {
      final result = await doLoginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (loginEntity) async {
          if (loginEntity.accessToken.isNotEmpty) {
            await saveUserToken(loginEntity.accessToken);
            await saveUserRefreshToken(loginEntity.refreshToken);
            await saveUserName(loginEntity.userFirstName);
            await saveUserEmail(emailController.text);
            await saveUserImage(loginEntity.userImage);
            await saveUserLogin(true);
            loginEntityStream.data = loginEntity;
            navigateToHome();
          }
        },
        (failure) {},
      );
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      loginEntityStream.show();
      safeSnackBar.error(S.current.textErrorLoginUnauthorized);
    }
  }

  void toogleLoginButton() {
    bool isEmailOk = emailController.text.isEmail;
    bool isPasswordOk = passwordController.text.isPassword;
    bool isButtonEnabled = (isEmailOk && isPasswordOk);
    isLoginEnabled.data = isButtonEnabled;
  }

  Future<void> saveUserLogin(bool value) async {
    try {
      await saveUserLoginUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> saveUserName(String value) async {
    try {
      await saveUserNameUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> saveUserEmail(String value) async {
    try {
      await saveUserEmailUseCase.call(userEmail: value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> saveUserImage(String value) async {
    try {
      await saveUserImageUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> saveUserToken(String value) async {
    try {
      await saveUserTokenUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> saveUserRefreshToken(String value) async {
    try {
      await saveUserRefreshTokenUseCase.call(value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
    }
  }

  String? validateEmail(String? value) {
    if (!(value ?? StringConstants.empty).isEmail) {
      return S.current.textErrorEmail;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (!(value ?? StringConstants.empty).isPassword) {
      return S.current.textErrorLoginPassword;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  Future<void> forgotPassword() async {
    final Uri url = Uri(
      scheme: StringConstants.https,
      host: FlavorUtil.instance.url.replaceAll(
        StringConstants.httpsComplete,
        StringConstants.empty,
      ),
      path: ApiConstants.kForgotPassword,
    );
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  void tooglePasswordVisibility() {
    isPassowordVisible.data = !isPassowordVisible.data;
  }

  @override
  Future<void> dispose() async {
    emailController.dispose();
    passwordController.dispose();
    isLoginEnabled.data = false;
    loginEntityStream.data = null;
  }
}
