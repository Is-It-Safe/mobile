import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
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
import 'package:result_dart/result_dart.dart';

import '../../../../../../components/widgets/safe_profile_picture/bloc/safe_profile_picture_bloc.dart';

class RegisterBloc extends SafeBloC {
  final DoRegisterUseCase doRegisterUseCase;
  final GetSexualOrientationsUseCase getSexualOrientationsUseCase;
  final GetGendersUseCase getGendersUseCase;
  final SafeProfilePictureBloC profilePictureController;

  late final MaskTextInputFormatter birthdayInputMask;
  late final MaskTextInputFormatter phoneInputMask;

  late StreamController<bool> registerButtonController;
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
  List<GenderEntity> listGenders = [];
  List<SexualOrientationEntity> listSexualOrientations = [];

  RegisterBloc({
    required this.doRegisterUseCase,
    required this.getGendersUseCase,
    required this.getSexualOrientationsUseCase,
    required this.profilePictureController,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    birthdayInputMask = MaskTextInputFormatter(mask: StringConstants.dateMask);
    phoneInputMask = MaskTextInputFormatter(mask: StringConstants.phoneMask);

    registerButtonController = StreamController.broadcast();
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
        confirmPasswordController.text == passwordController.text &&
        isTermsAndConditionsChecked);
    registerButtonController.sink.add(isRegisterButtonEnabled);
  }

  Future<void> getGenders() async {
    try {
      if (listGenders.isEmpty) {
        gendersController.sink.add(SafeEvent.load());
        await getGendersUseCase.call().fold(
          (success) {
            listGenders = success;
          },
          (error) {},
        );
        gendersController.sink.add(SafeEvent.done(listGenders));
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      gendersController.addError(e.toString());
    }
  }

  Future<void> getSexualOrientations() async {
    try {
      if (listSexualOrientations.isEmpty) {
        sexualOrientationsController.sink.add(SafeEvent.load());
        await getSexualOrientationsUseCase.call().fold(
          (success) {
            listSexualOrientations = success;
          },
          (error) {},
        );
        sexualOrientationsController.sink.add(
          SafeEvent.done(listSexualOrientations),
        );
      }
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      sexualOrientationsController.addError(e.toString());
    }
  }

  Future<void> doRegister({bool? isAdvanceButton}) async {
    try {
      birthdateController.text.isEmpty == true
          ? StringConstants.empty
          : birthdateController.text;
      profilePictureController.selectedProfilePhoto.isEmpty == true
          ? StringConstants.empty
          : profilePictureController.selectedProfilePhoto;
      genderController.text.isEmpty == true
          ? StringConstants.empty
          : genderController.text;
      sexualOrientationController.text.isEmpty == true
          ? StringConstants.empty
          : sexualOrientationController.text;
      doRegisterController.add(SafeEvent.load());
      await doRegisterUseCase
          .call(
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
            : profilePictureController.selectedProfilePhoto,
        gender: isAdvanceButton == true ? 7 : int.parse(genderController.text),
        sexualOrientation: isAdvanceButton == true
            ? 8
            : int.parse(sexualOrientationController.text),
      )
          .fold(
        (success) {
          doRegisterController.add(SafeEvent.done(success));
        },
        (error) {
          // TODO Refatorar código
          doRegisterController.add(SafeEvent.error(error.message));
        },
      );
    } catch (e) {
      SafeLogUtil.instance.logError(e);
      doRegisterController.addError(e.toString());
    }
  }

  validateNameTextField(String? value) {
    if (!ValidationUtil.name(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorEmptyField;
    } else if (value.length < 3) {
      return S.current.textRegisterValidateUserName;
    }
    return null;
  }

  validateUserNameTextField(String? value) {
    if (!ValidationUtil.name(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorEmptyField;
    } else if (value.length < 3) {
      return S.current.textRegisterValidateUserName;
    }
    return null;
  }

  validateEmail(String? value) {
    if (!ValidationUtil.email(value ?? StringConstants.empty) ||
        value == null) {
      return S.current.textErrorEmail;
    }
    return null;
  }

  validatePassword(String? value) {
    if (!ValidationUtil.passoword(value ?? StringConstants.empty) ||
        value == null) {
      return S.current.textErrorLoginPassword;
    }
    return null;
  }

  validateConfirmPassword(String? value) {
    if (!ValidationUtil.passoword(value ?? StringConstants.empty) ||
        value == null) {
      return S.current.textErrorLoginPassword;
    }
    if (value != passwordController.text) {
      return S.current.textErrorDifferentPasswords;
    }
    return null;
  }

  validateBirthdate(String? value) {
    if (!ValidationUtil.date(value ?? StringConstants.empty) || value == null) {
      return S.current.textErrorInvalidDate;
    } else if (value.length < 10) {
      return S.current.textErrorInvalidDate;
    }
    return null;
  }

  void toogleTermsAndConditions() {
    isTermsAndConditionsChecked = !isTermsAndConditionsChecked;
  }

  @override
  Future<void> dispose() async {}
}
