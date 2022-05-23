import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/login/login_contract.dart';

import 'package:is_it_safe_app/core/model/Auth.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences_contract.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';

import 'package:is_it_safe_app/core/utils/helper/log.dart';

class LoginBloc implements Disposable {
  final LoginContract service;
  final CustomSharedPreferencesContract customSharedPreferences;

  late StreamController<bool> loginButtonController;
  late StreamController<BaseResponse<Auth>> loginController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  Auth? auth;

  LoginBloc({required this.service, required this.customSharedPreferences}) {
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
      customSharedPreferences.saveUsuario(true);
      customSharedPreferences.saveUsuarioToken(auth?.accessToken);
      customSharedPreferences.saveUsuarioRefreshToken(auth?.refreshToken);
      loginController.sink.add(BaseResponse.completed(data: auth));
    } catch (e, stack) {
      loginController.sink.add(BaseResponse.error(e.toString()));
      Log.log(stack.toString(), name: "LOGIN ERROR");
    }
  }

  void enableLoginButton() {
    bool isUsernameOk = (Helpers.validateName(usernameController.text));
    bool isPasswordOk = (passwordController.text.isNotEmpty &&
        Helpers.validatePassword(passwordController.text));
    bool isBtnEnable = (isUsernameOk && isPasswordOk);
    loginButtonController.sink.add(isBtnEnable);
  }

  @override
  void dispose() {
    loginButtonController.close();
  }
}
