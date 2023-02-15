import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_image_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_name_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:result_dart/result_dart.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginBloc extends SafeBloC {
  final DoLoginUseCase doLoginUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;
  final SaveUserRefreshTokenUseCase saveUserRefreshTokenUseCase;
  final SaveUserImageUseCase saveUserImageUseCase;
  final SaveUserNameUseCase saveUserNameUseCase;

  late StreamController<bool> loginButtonController;
  late StreamController<SafeEvent<LoginEntity>> doLoginController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  LoginBloc({
    required this.doLoginUseCase,
    required this.saveUserLoginUseCase,
    required this.saveUserTokenUseCase,
    required this.saveUserRefreshTokenUseCase,
    required this.saveUserImageUseCase,
    required this.saveUserNameUseCase,
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
      await doLoginUseCase
          .call(
        email: emailController.text,
        password: passwordController.text,
      )
          .fold((loginEntity) async {
        if (loginEntity.accessToken.isNotEmpty) {
          await saveUserToken(loginEntity.accessToken);
          await saveUserRefreshToken(loginEntity.refreshToken);
          await saveUserName(loginEntity.userFirstName);
          await saveUserImage(loginEntity.userImage);
          await saveUserLogin(true);
        }
        doLoginController.sink.add(SafeEvent.done(loginEntity));
      }, (error) => null);
    } catch (e) {
      doLoginController.addError(e.toString());
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

  Future<void> saveUserName(String value) async {
    try {
      await saveUserNameUseCase.call(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> saveUserImage(String value) async {
    try {
      await saveUserImageUseCase.call(value);
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

  Future<void> forgotPassword(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Future<void> dispose() async {}
}
