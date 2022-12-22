import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterBloc extends SafeBloC {
  final DoRegisterUseCase doRegisterUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;

  late final MaskTextInputFormatter birthdayInputMask;
  late final MaskTextInputFormatter phoneInputMask;

  late StreamController<bool> registerButtonController;
  late StreamController<String> profilePictureController;
  late StreamController<SafeEvent<List<GenderEntity>>> gendersController;
  late StreamController<SafeEvent<List<SexualOrientationEntity>>>
      sexualOrientationsController;
  late StreamController<SafeEvent<RegisterEntity>> doRegisterController;

  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController pronounController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController birthdateController;
  late TextEditingController genderController;
  late TextEditingController sexualOrientationController;

  bool isTermsAndConditionsChecked = false;
  List<String> listProfilePicturePaths = [];
  List<GenderEntity> listGenders = [];
  List<SexualOrientationEntity> listSexualOrientations = [];
  String selectedProfilePhoto = StringConstants.empty;

  RegisterBloc({
    required this.doRegisterUseCase,
    required this.getGendersUseCase,
    required this.getSexualOrientationsUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    birthdayInputMask = MaskTextInputFormatter(mask: StringConstants.dateMask);
    phoneInputMask = MaskTextInputFormatter(mask: StringConstants.phoneMask);

    registerButtonController = StreamController.broadcast();
    profilePictureController = StreamController.broadcast();
    gendersController = StreamController.broadcast();
    sexualOrientationsController = StreamController.broadcast();
    doRegisterController = StreamController.broadcast();

    nameController = TextEditingController();
    usernameController = TextEditingController();
    pronounController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    birthdateController = TextEditingController();
    genderController = TextEditingController();
    sexualOrientationController = TextEditingController();
  }

  void toogleRegisterButton() {
    bool isRegisterButtonEnabled = (nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        isTermsAndConditionsChecked);
    registerButtonController.sink.add(isRegisterButtonEnabled);
  }

  Future<void> getProfilePicturePathsList(BuildContext context) async {
    listProfilePicturePaths.clear();
    final assetManifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final List<String> profilePicturePaths = json
        .decode(assetManifestJson)
        .keys
        .where((String key) =>
            key.startsWith(AssetConstants.general.profilePictures))
        .toList();
    listProfilePicturePaths.addAll(profilePicturePaths);
  }

  void setProfitePicture(String path) {
    selectedProfilePhoto = path;
    profilePictureController.sink.add(path);
  }

  Future<void> getGenders() async {
    try {
      if (listGenders.isEmpty) {
        gendersController.sink.add(SafeEvent.load());
        listGenders = await getGendersUseCase.call();
        gendersController.sink.add(SafeEvent.done(listGenders));
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      // gendersController.sink.add(SafeEvent.error(e.toString())); /// [Deprecated]
      gendersController.addError(e.toString());
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.isEmpty) {
        sexualOrientationsController.sink.add(SafeEvent.load());
        listSexualOrientations = await getSexualOrientationsUseCase.call();
        sexualOrientationsController.sink.add(
          SafeEvent.done(listSexualOrientations),
        );
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      // sexualOrientationsController.sink.add(SafeEvent.error(e.toString())); /// [Deprecated]
      sexualOrientationsController.addError(e.toString());
    }
  }

  Future<void> doRegister({
    bool? isAdvanceButton,
  }) async {
    try {
      doRegisterController.sink.add(SafeEvent.load());
      final response = await doRegisterUseCase.call(
        name: nameController.text,
        username: usernameController.text,
        birthDate: isAdvanceButton == true
            ? StringConstants.empty
            : birthdateController.text,
        pronoun: pronounController.text,
        email: emailController.text,
        password: passwordController.text,
        profilePhoto: isAdvanceButton == true
            ? StringConstants.empty
            : selectedProfilePhoto,
        gender: isAdvanceButton == true ? "${7}" : genderController.text,
        sexualOrientation:
            isAdvanceButton == true ? "${2}" : sexualOrientationController.text,
      );
      doRegisterController.sink.add(SafeEvent.done(response));
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      // doRegisterController.sink.add(SafeEvent.error(e.toString())); /// [Deprecated]
      doRegisterController.addError(e.toString());
    }
  }

  String validateTextField(String? value) {
    if (!ValidationUtil.name(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorEmptyField;
    }
    return StringConstants.empty;
  }

  String validateEmail(String? value) {
    if (!ValidationUtil.email(value ?? StringConstants.empty) ||
        value == null) {
      return S.current.textErrorEmail;
    }
    return StringConstants.empty;
  }

  String validatePassword(
    String? value, {
    String? errorText,
  }) {
    if (!ValidationUtil.passoword(value ?? StringConstants.empty) ||
        value == null) {
      return errorText ?? S.current.textErrorLoginPassword;
    }
    return StringConstants.empty;
  }

  String validateBirthdate(String? value) {
    if (!ValidationUtil.date(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorInvalidDate;
    }
    return StringConstants.empty;
  }

  void toogleTermsAndConditions() {
    isTermsAndConditionsChecked = !isTermsAndConditionsChecked;
  }

  @override
  Future<void> dispose() async {}
}
