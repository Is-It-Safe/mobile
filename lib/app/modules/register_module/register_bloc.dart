import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/register_service.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/model/User.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterBloc implements Disposable {
  final RegisterService _service = RegisterService();

  ///Finals
  final MaskTextInputFormatter birthdayInputMask =
      MaskTextInputFormatter(mask: "##/##/####");

  ///StreamControllers
  late StreamController<bool> registerButtonController;
  late StreamController<String> profileAvatarController;
  late StreamController<BaseResponse<List<Gender>>> dropGendersController;
  late StreamController<BaseResponse<List<SexualOrientation>>>
      dropOrientationController;
  late StreamController<BaseResponse> registrationController;

  ///TextEditingControllers
  late TextEditingController nameController;
  late TextEditingController userNameController;
  late TextEditingController pronoumsController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController birthdayController;
  late TextEditingController genderController;
  late TextEditingController sexualOrientationController;

  bool termsAndConditionsCheckbox = false;
  List<String> profileAvatarPaths = [];
  String selectedProfileAvatarPhoto = '';

  RegisterBloc() {
    registerButtonController = StreamController.broadcast();
    profileAvatarController = StreamController.broadcast();
    dropGendersController = StreamController.broadcast();
    dropOrientationController = StreamController.broadcast();
    registrationController = StreamController.broadcast();

    nameController = TextEditingController();
    userNameController = TextEditingController();
    pronoumsController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    birthdayController = TextEditingController();
    genderController = TextEditingController();
    sexualOrientationController = TextEditingController();
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
    selectedProfileAvatarPhoto = path;
    profileAvatarController.sink.add(path);
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

  Future getGenders() async {
    try {
      dropGendersController.sink.add(BaseResponse.loading());
      final genders = await _service.getGenders();
      dropGendersController.sink.add(BaseResponse.completed(data: genders));
    } catch (e) {
      dropGendersController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  Future getSexualOrientations() async {
    try {
      dropOrientationController.sink.add(BaseResponse.loading());
      final orientations = await _service.getSexualOrientations();
      dropOrientationController.sink
          .add(BaseResponse.completed(data: orientations));
    } catch (e) {
      dropOrientationController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  Future registerUser() async {
    late var response;
    if (genderController.text.isEmpty) {
      genderController.text = 11.toString();
    }
    if (sexualOrientationController.text.isEmpty) {
      sexualOrientationController.text = 8.toString();
    }
    final user = User(
      birthDate: birthdayController.text,
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      genderId: int.parse(genderController.text),
      orientationId: int.parse(sexualOrientationController.text),
      nickname: userNameController.text.trim(),
      password: passwordController.text.trim(),
      photoUrl: selectedProfileAvatarPhoto,
      pronoun: pronoumsController.text.trim(),
    );
    try {
      registrationController.sink.add(BaseResponse.loading());
      response = await _service.registerUser(user: user);
      registrationController.sink.add(BaseResponse.completed(data: response));
    } catch (e) {
      registrationController.sink.add(BaseResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    registerButtonController.close();
    dropGendersController.close();
    dropOrientationController.close();
  }
}
