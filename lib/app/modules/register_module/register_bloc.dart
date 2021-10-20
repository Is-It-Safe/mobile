import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterBloc implements Disposable {
  ///StreamControllers
  late StreamController<bool> registerButtonController;

  ///TextEditingControllers
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController pronoumsController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool termsAndConditionsCheckbox = false;

  RegisterBloc() {
    registerButtonController = StreamController.broadcast();

    nameController = TextEditingController();
    userNameController = TextEditingController();
    pronoumsController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  enableRegisterButton() {
    bool isRegisterButtonEnable = (nameController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        termsAndConditionsCheckbox);
    registerButtonController.sink.add(isRegisterButtonEnable);
  }

  @override
  void dispose() {}
}
