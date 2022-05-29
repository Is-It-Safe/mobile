import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/entity/login_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/do_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_login_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_refresh_token_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/domain/use_case/save_user_token_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';

class LoginBloc extends SafeBloC {
  late final DoLoginUseCase _doLoginUseCase;
  late final SaveUserLoginUseCase _saveUserLoginUseCase;
  late final SaveUserTokenUseCase _saveUserTokenUseCase;
  late final SaveUserRefreshTokenUseCase _saveUserRefreshTokenUseCase;

  late StreamController<bool> loginButtonController;
  late StreamController<SafeResponse<LoginEntity>> doLoginController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  LoginBloc() {
    init();
  }

  @override
  Future<void> init() async {
    _doLoginUseCase = Modular.get<DoLoginUseCase>();
    _saveUserLoginUseCase = Modular.get<SaveUserLoginUseCase>();
    _saveUserTokenUseCase = Modular.get<SaveUserTokenUseCase>();
    _saveUserRefreshTokenUseCase = Modular.get<SaveUserRefreshTokenUseCase>();
    loginButtonController = StreamController.broadcast();
    doLoginController = StreamController.broadcast();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> doLogin() async {
    try {
      doLoginController.sink.add(SafeResponse.loading());
      LoginEntity loginEntity = await _doLoginUseCase.call(
        username: usernameController.text,
        password: passwordController.text,
      );
      saveUserToken(loginEntity.accessToken);
      saveUserRefreshToken(loginEntity.refreshToken);
      saveUserLogin(true);
      doLoginController.sink.add(SafeResponse.completed(data: loginEntity));
    } catch (e) {
      doLoginController.sink.add(SafeResponse.error(e.toString()));
      LogUtil().error(e.toString(), title: 'LOGIN ERROR');
    }
  }

  void toogleLoginButton() {
    bool isUsernameOk = ValidationUtil.name(usernameController.text);
    bool isPasswordOk = ValidationUtil.passoword(passwordController.text);
    bool isButtonEnabled = (isUsernameOk && isPasswordOk);
    loginButtonController.sink.add(isButtonEnabled);
  }

  Future<void> saveUserLogin(bool value) async {
    try {
      await _saveUserLoginUseCase.call(value);
    } catch (e) {
      LogUtil().error(e.toString());
    }
  }

  Future<void> saveUserToken(String value) async {
    try {
      await _saveUserTokenUseCase.call(value);
    } catch (e) {
      LogUtil().error(e.toString());
    }
  }

  Future<void> saveUserRefreshToken(String value) async {
    try {
      await _saveUserRefreshTokenUseCase.call(value);
    } catch (e) {
      LogUtil().error(e.toString());
    }
  }

  String validateUsername(
    BuildContext context, {
    required String? value,
  }) {
    if (!ValidationUtil.name(value ?? StringConstants.empty)) {
      S.of(context).textErrorLoginUsername;
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
