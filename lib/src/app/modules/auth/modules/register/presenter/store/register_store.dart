import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/vo/register_user_vo.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/register_entity.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';

class RegisterStore {
  final registerEntity = SafeStream<RegisterEntity?>(data: null);
  final isRegisterButtonEnabled = SafeStream<bool>(data: false);
  final profilePicture = SafeStream<String>(data: StringConstants.empty);
  final isTermsAndConditionsChecked = SafeStream<bool>(data: false);
  final isPasswordVisible = SafeStream<bool>(data: false);
  final selectedProfilePhoto = SafeStream<String>(data: StringConstants.empty);
  final temporarySelectedProfilePhoto = SafeStream<String>(
    data: StringConstants.empty,
  );
  final listProfilePicturePaths = SafeStream<List<String>>(data: []);
  final listGender = SafeStream<List<GenderEntity>>(data: []);
  final listSexualOrientation = SafeStream<List<SexualOrientationEntity>>(
    data: [],
  );
  final isUsernameAvailable = SafeStream<bool>(data: false);
  final isEmailAvailable = SafeStream<bool>(data: false);

  final birthdayInputMask = MaskTextInputFormatter(
    mask: StringConstants.dateMask,
  );
  final MaskTextInputFormatter phoneInputMask = MaskTextInputFormatter(
    mask: StringConstants.phoneMask,
  );

  final List<RegisterUserVo> registerUserVoList = List.generate(
    UserSignInEnum.values.length,
    (index) {
      return RegisterUserVo(
        userSignInEnum: UserSignInEnum.values[index],
      );
    },
  );

  final genderTextController = TextEditingController();
  final sexualOrientationTextController = TextEditingController();
  final birthdateTextController = TextEditingController();

  void dispose() {
    birthdateTextController.clear();
    genderTextController.clear();
    sexualOrientationTextController.clear();

    registerUserVoList.clear();
    registerEntity.data = null;
    isRegisterButtonEnabled.data = false;
    profilePicture.data = StringConstants.empty;
    isTermsAndConditionsChecked.data = false;
    isPasswordVisible.data = false;
    selectedProfilePhoto.data = StringConstants.empty;
    temporarySelectedProfilePhoto.data = StringConstants.empty;
    listProfilePicturePaths.data = [];
    listGender.data = [];
    listSexualOrientation.data = [];
  }
}
