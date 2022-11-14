import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';

class LoginBloc extends SafeBloC {
  final DoLoginUseCase doLoginUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;
  final SaveUserRefreshTokenUseCase saveUserRefreshTokenUseCase;

  late StreamController<bool> loginButtonController;
  late StreamController<SafeEvent<LoginEntity>> doLoginController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginBloc({
    required this.doLoginUseCase,
    required this.saveUserLoginUseCase,
    required this.saveUserTokenUseCase,
    required this.saveUserRefreshTokenUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    loginButtonController = StreamController.broadcast();
    doLoginController = StreamController.broadcast();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> doLogin() async {
    try {
      doLoginController.sink.add(SafeEvent.load());
      LoginEntity loginEntity = await doLoginUseCase.call(
        email: emailController.text,
        password: passwordController.text,
      );
      if (loginEntity.accessToken.isNotEmpty) {
        saveUserToken(loginEntity.accessToken);
        saveUserRefreshToken(loginEntity.refreshToken);
        saveUserLogin(true);
      }
      doLoginController.sink.add(SafeEvent.done(loginEntity));
    } catch (e) {
      doLoginController.addError(SafeEvent.error(e.toString()));
      SafeLogUtil.instance.logError(e);
    }
  }

  void toogleLoginButton() {
    bool isUsernameOk = ValidationUtil.name(emailController.text);
    bool isPasswordOk = ValidationUtil.passoword(passwordController.text);
    bool isButtonEnabled = (isUsernameOk && isPasswordOk);
    loginButtonController.sink.add(isButtonEnabled);
  }

  Future<void> saveUserLogin(bool value) async {
    try {
      await saveUserLoginUseCase.call(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> saveUserToken(String value) async {
    try {
      await saveUserTokenUseCase.call(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> saveUserRefreshToken(String value) async {
    try {
      await saveUserRefreshTokenUseCase.call(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  String validateEmail(
    BuildContext context, {
    required String? value,
  }) {
    if (!ValidationUtil.email(value ?? StringConstants.empty)) {
      S.of(context).textErrorEmail;
    }
    return StringConstants.empty;
  }

  String validatePassword(
    BuildContext context, {
    required String? value,
  }) {
    if (!ValidationUtil.passoword(value ?? StringConstants.empty)) {
      S.of(context).textErrorLoginPassword;
    }
    return StringConstants.empty;
  }

  @override
  Future<void> dispose() async {}
}
