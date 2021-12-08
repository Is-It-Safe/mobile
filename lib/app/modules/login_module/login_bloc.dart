import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/login_service.dart';
import 'package:is_it_safe_app/core/model/Auth.dart';
import 'package:is_it_safe_app/core/utils/config/custom_shared_preferences.dart';

import 'dart:developer' as dev;

import 'package:is_it_safe_app/core/utils/helper/helpers.dart';

class LoginBloc implements Disposable {
  final LoginService _service = LoginService();
  late StreamController<bool> loginButtonController;
  late StreamController<BaseResponse<Auth>> loginController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  LoginBloc() {
    loginButtonController = StreamController.broadcast();
    loginController = StreamController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future doLogin() async {
    try {
      var _response = await _service.doLogin(
        username: usernameController.text,
        password: passwordController.text,
      );
      Auth auth = Auth.fromJson(_response);
      await CustomSharedPreferences.saveUsuario(true);
      await CustomSharedPreferences.saveUsuarioToken(auth.accessToken);
      loginController.sink.add(BaseResponse.completed(data: auth));
    } catch (e) {
      loginController.sink.add(BaseResponse.error(e.toString()));
      dev.log(e.toString(), name: "LOGIN ERROR");
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
