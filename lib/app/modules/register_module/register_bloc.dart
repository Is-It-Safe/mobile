import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/register_service.dart';
import 'package:is_it_safe_app/core/model/Gender.dart';
import 'package:is_it_safe_app/core/model/SexualOrientation.dart';
import 'package:is_it_safe_app/core/model/User.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'dart:developer' as dev;

class RegisterBloc implements Disposable {

  final RegisterService _service = RegisterService();

  ///Finals
  final MaskTextInputFormatter birthdayInputMask =
      MaskTextInputFormatter(mask: "##/##/####");

  ///StreamControllers
  late StreamController<bool> registerButtonController;
  late StreamController<String> profileAvatarController;
  late StreamController<List<Gender>> dropGendersController;
  late StreamController<List<SexualOrientation>> dropOrientationController;
  //TODO: Criar controllers de orientation e genders

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
    profileAvatarController = StreamController.broadcast();
    dropGendersController = StreamController.broadcast();
    dropOrientationController = StreamController.broadcast();

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
    selectedProfileAvatarPhoto = path;
    dev.log(path, name: "AVATAR PATH");
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
    final genders =  await _service.getGenders();
    dropGendersController.sink.add(genders);
  }

  Future getSexualOrientations() async {
    final orientations = await _service.getSexualOrientations();
    dropOrientationController.sink.add(orientations);
  }


  Future registerUser({required int genderId,required orientationId }) async {
    final user = User(
      birthDate: birthdayController.text,
      email: emailController.text,
      name: nameController.text,
      genderId: genderId,
      orientationId: orientationId,
      nickname: userNameController.text,
      password: passwordController.text,
      photoUrl: selectedProfileAvatarPhoto,
      pronoun: pronoumsController.text,
    );
    await _service.registerUser(user: user);
  }


  //TODO: Verificar com o back os numeros corretos dos id's de cada um
  int convertOrientationID(String orientationName){
    switch (orientationName) {
      case 'Gay':
          return 1;
      case 'Lésbica':
          return 2;
      case 'Bissexual':
          return 3;
      case 'Pansexual':
          return 4;
      case 'Assexual':
          return 5;
      case 'Queer':
          return 6;
      case 'Heterosexual':
          return 7;
      case 'Prefiro Não Respodner':
          return 0;
      default:
          return 0;
    }
  }

  //TODO: Verificar com o back os numeros corretos dos id's de cada um
  int convertGenderID(String genderName){
    switch (genderName) {
      case 'Mulher Cis':
          return 1;
      case 'Mulher Trans':
          return 2;
      case 'Homem Cis':
          return 3;
      case 'Homen Trans':
          return 4;
      case 'Pessoa Não-Binárie':
          return 5;
      case 'Queer':
          return 6;
      case 'Prefiro Não Respodner':
          return 0;
      default:
          return 0;
    }
  }



  @override
  void dispose() {
    registerButtonController.close();
    profileAvatarController.close();
    dropGendersController.close();
    dropOrientationController.close();
  }
}
