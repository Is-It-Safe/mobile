import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/login/login.dart';
import 'package:is_it_safe_app/core/data/service/login/login_contract.dart';

import 'package:is_it_safe_app/core/model/Auth.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';

import 'package:is_it_safe_app/core/utils/helper/log.dart';

class LoginBloc implements Disposable {
  final LoginContract service;
  late StreamController<bool> loginButtonController;
  late StreamController<BaseResponse<Auth>> loginController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  LoginBloc({required this.service}) {
    loginButtonController = StreamController.broadcast();
    loginController = StreamController.broadcast();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future doLogin() async {
    var _response;
    try {
      loginController.sink.add(BaseResponse.loading());
      _response = await service.doLogin(
        username: usernameController.text,
        password: passwordController.text,
      );
      Auth auth = Auth.fromJson(_response);
      await CustomSharedPreferences.saveUsuario(true);
      await CustomSharedPreferences.saveUsuarioToken(auth.accessToken);
      await CustomSharedPreferences.saveUsuarioRefreshToken(auth.refreshToken);
      loginController.sink.add(BaseResponse.completed(data: auth));
    } catch (e) {
      loginController.sink.add(BaseResponse.error(e.toString()));
      Log.log(e.toString(), name: "LOGIN ERROR");
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
