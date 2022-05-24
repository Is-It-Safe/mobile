import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/login/login_contract.dart';

import 'package:is_it_safe_app/core/model/Auth.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/ishared_preferences_custom.dart';
import 'package:is_it_safe_app/src/util/constants/string_constants.dart';

import 'package:is_it_safe_app/src/util/log_util.dart';
import 'package:is_it_safe_app/src/util/validation_util.dart';

class LoginBloc implements Disposable {
  final LoginContract service;
  final ISharedPreferencesCustom sharedPreferences;

  late StreamController<bool> loginButtonController;
  late StreamController<BaseResponse<Auth>> loginController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  Auth? auth;

  LoginBloc({required this.service, required this.sharedPreferences}) {
    loginButtonController = StreamController.broadcast();
    loginController = StreamController.broadcast();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future doLogin() async {
    Map<String, dynamic> _response;
    try {
      loginController.sink.add(BaseResponse.loading());
      _response = await service.doLogin(
        username: usernameController.text,
        password: passwordController.text,
      );
      auth = Auth.fromJson(_response);
      sharedPreferences.saveLogin(true);
      sharedPreferences.saveToken(
        auth?.accessToken ?? StringConstants.empty,
      );
      sharedPreferences.saveRefreshToken(
        auth?.refreshToken ?? StringConstants.empty,
      );
      loginController.sink.add(BaseResponse.completed(data: auth));
    } catch (e, stack) {
      loginController.sink.add(BaseResponse.error(e.toString()));
      LogUtil().error(stack.toString(), title: 'LOGIN ERROR');
    }
  }

  void enableLoginButton() {
    bool isUsernameOk = (ValidationUtil.name(usernameController.text));
    bool isPasswordOk = (passwordController.text.isNotEmpty &&
        ValidationUtil.passowrd(passwordController.text));
    bool isBtnEnable = (isUsernameOk && isPasswordOk);
    loginButtonController.sink.add(isBtnEnable);
  }

  @override
  void dispose() {
    loginButtonController.close();
  }
}

class LogUtillog {}
