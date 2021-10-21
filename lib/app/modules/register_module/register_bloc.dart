import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterBloc implements Disposable {
  ///Finals
  final MaskTextInputFormatter birthdayInputMask =
      MaskTextInputFormatter(mask: "##/##/####");

  ///StreamControllers
  late StreamController<bool> registerButtonController;
  late StreamController<String> profileAvatarController;

  ///TextEditingControllers
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController pronoumsController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController birthdayController;

  bool termsAndConditionsCheckbox = false;

  RegisterBloc() {
    registerButtonController = StreamController.broadcast();
    profileAvatarController = StreamController.broadcast();

    nameController = TextEditingController();
    userNameController = TextEditingController();
    pronoumsController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    birthdayController = TextEditingController();
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

  setProfileAvatar({required String path}) {
    profileAvatarController.sink.add(path);
  }

  @override
  void dispose() {
    registerButtonController.close();
    profileAvatarController.close();
  }
}
