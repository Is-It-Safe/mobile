import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/use_case/do_register_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/use_case/get_genders_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/domain/use_case/get_sexual_orientation_use_case.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/service/api/configuration/stream_response.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterBloc extends SafeBloC {
  late final DoRegisterUseCase _doRegisterUseCase;
  late final GetSexualOrientationsUseCase _getSexualOrientationsUseCase;
  late final GetGendersUseCase _getGendersUseCase;

  late final MaskTextInputFormatter birthdayInputMask;
  late final MaskTextInputFormatter phoneInputMask;

  late StreamController<bool> registerButtonController;
  late StreamController<String> profilePictureController;
  late StreamController<SafeResponse<List<GenderEntity>>> gendersController;
  late StreamController<SafeResponse<List<SexualOrientationEntity>>>
      sexualOrientationsController;
  late StreamController<SafeResponse<RegisterEntity>> doRegisterController;

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

  RegisterBloc() {
    init();
  }

  @override
  Future<void> init() async {
    _doRegisterUseCase = Modular.get<DoRegisterUseCase>();
    _getSexualOrientationsUseCase = Modular.get<GetSexualOrientationsUseCase>();
    _getGendersUseCase = Modular.get<GetGendersUseCase>();

    birthdayInputMask = MaskTextInputFormatter(mask: StringConstants.dateMask);
    phoneInputMask = MaskTextInputFormatter(mask: StringConstants.phoneMask);

    registerButtonController = StreamController.broadcast();
    profilePictureController = StreamController.broadcast();
    gendersController = StreamController.broadcast();
    sexualOrientationsController = StreamController.broadcast();
    doRegisterController = StreamController.broadcast();

    nameController = TextEditingController(text: 'ester');
    usernameController = TextEditingController(text: 'ester1');
    pronounController = TextEditingController();
    emailController = TextEditingController(text: 'ester1@gmail.com');
    passwordController = TextEditingController(text: '1234567q');
    confirmPasswordController = TextEditingController(text: '1234567q');
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
    final List<String> _profilePicturePaths = json
        .decode(assetManifestJson)
        .keys
        .where((String key) => key.startsWith(AssetConstants.profilePictures))
        .toList();
    listProfilePicturePaths.addAll(_profilePicturePaths);
  }

  void setProfitePicture(String path) {
    selectedProfilePhoto = path;
    profilePictureController.sink.add(path);
  }

  Future<void> getGenders() async {
    try {
      if (listGenders.isEmpty) {
        gendersController.sink.add(SafeResponse.loading());
        listGenders = await _getGendersUseCase.call();
        gendersController.sink.add(SafeResponse.completed(data: listGenders));
      }
    } catch (e) {
      LogUtil().error(e.toString());
      gendersController.sink.add(SafeResponse.error(e.toString()));
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.isEmpty) {
        sexualOrientationsController.sink.add(SafeResponse.loading());
        listSexualOrientations = await _getSexualOrientationsUseCase.call();
        sexualOrientationsController.sink.add(
          SafeResponse.completed(data: listSexualOrientations),
        );
      }
    } catch (e) {
      LogUtil().error(e.toString());
      sexualOrientationsController.sink.add(SafeResponse.error(e.toString()));
    }
  }

  Future<void> doRegister({
    bool? isAdvanceButton,
  }) async {
    try {
      doRegisterController.sink.add(SafeResponse.loading());
      final _response = await _doRegisterUseCase.call(
        name: nameController.text,
        username: usernameController.text,
        birthDate: isAdvanceButton == true
            ? birthdateController.text
            : StringConstants.empty,
        pronoun: pronounController.text,
        email: emailController.text,
        password: passwordController.text,
        profilePhoto: isAdvanceButton == true
            ? selectedProfilePhoto
            : StringConstants.empty,
        gender: isAdvanceButton == true ? genderController.text : 11.toString(),
        sexualOrientation: isAdvanceButton == true
            ? sexualOrientationController.text
            : 8.toString(),
      );
      doRegisterController.sink.add(SafeResponse.completed(data: _response));
    } catch (e) {
      LogUtil().error(e.toString());
      doRegisterController.sink.add(SafeResponse.error(e.toString()));
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
