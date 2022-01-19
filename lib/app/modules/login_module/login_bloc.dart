import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/login_service.dart';

import 'dart:developer' as dev;

import 'package:is_it_safe_app/core/utils/helper/helpers.dart';

class LoginBloc implements Disposable {
  final LoginService _service = LoginService();
  late StreamController<bool> loginButtonController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  LoginBloc() {
    loginButtonController = StreamController.broadcast();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future doLogin() async {
    try {
      await _service.doLogin(
        username: usernameController.text,
        password: passwordController.text,
      );
    } catch (e) {
      //TODO add login error
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