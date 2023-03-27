import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterStore {
  final registerEntity = SafeStream<RegisterEntity?>(data: null);
  final isRegisterButtonEnabled = SafeStream<bool>(data: false);
  final profilePicture = SafeStream<String>(data: StringConstants.empty);
  final isTermsAndConditionsChecked = SafeStream<bool>(data: false);
  final isPassowordVisible = SafeStream<bool>(data: false);
  final selectedProfilePhoto = SafeStream<String>(data: StringConstants.empty);
  final temporarySelectedProfilePhoto = SafeStream<String>(
    data: StringConstants.empty,
  );
  final listProfilePicturePaths = SafeStream<List<String>>(data: []);
  final listGender = SafeStream<List<GenderEntity>>(data: []);
  final listSexualOrientation = SafeStream<List<SexualOrientationEntity>>(
    data: [],
  );

  final birthdayInputMask = MaskTextInputFormatter(
    mask: StringConstants.dateMask,
  );
  final MaskTextInputFormatter phoneInputMask = MaskTextInputFormatter(
    mask: StringConstants.phoneMask,
  );

  final nameTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  final pronounTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final birthdateTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final sexualOrientationTextController = TextEditingController();

  void dispose() {
    nameTextController.dispose();
    usernameTextController.dispose();
    pronounTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    birthdateTextController.dispose();
    genderTextController.dispose();
    sexualOrientationTextController.dispose();

    registerEntity.data = null;
    isRegisterButtonEnabled.data = false;
    profilePicture.data = StringConstants.empty;
    isTermsAndConditionsChecked.data = false;
    isPassowordVisible.data = false;
    selectedProfilePhoto.data = StringConstants.empty;
    temporarySelectedProfilePhoto.data = StringConstants.empty;
    listProfilePicturePaths.data = [];
    listGender.data = [];
    listSexualOrientation.data = [];
  }
}
