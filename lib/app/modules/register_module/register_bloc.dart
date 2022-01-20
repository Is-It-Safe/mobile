import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'dart:developer' as dev;

class RegisterBloc implements Disposable {
  ///Finals
  final MaskTextInputFormatter birthdayInputMask =
      MaskTextInputFormatter(mask: "##/##/####");

  ///StreamControllers
  late StreamController<bool> registerButtonController;
  ValueNotifier<String?> photoNotifier = ValueNotifier(null);

  ///TextEditingControllers
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController pronoumsController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController birthdayController;

  bool termsAndConditionsCheckbox = false;
  List<String> profileAvatarPaths = [];
  String selectedProfileAvatarPhoto = '';

  RegisterBloc() {
    registerButtonController = StreamController.broadcast();

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
    photoNotifier.value = path;
  }

  readProfileAvatarFiles(BuildContext context) async {
    profileAvatarPaths.clear();
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final List<String> _paths = json
        .decode(manifestJson)
        .keys
        .where((String key) =>
            key.startsWith('images/app/profile_pictures/profile_pic_'))
        .toList();
    profileAvatarPaths.addAll(_paths);
  }

  @override
  void dispose() {
    registerButtonController.close();
  }
}
