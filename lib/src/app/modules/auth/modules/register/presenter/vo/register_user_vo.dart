import 'package:flutter/cupertino.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';

class RegisterUserVo {
  final UserSignInEnum userSignInEnum;
  final TextEditingController controller = TextEditingController();
  bool isValid = false;

  RegisterUserVo({
    required this.userSignInEnum,
  }) {
    if (userSignInEnum == UserSignInEnum.pronouns) {
      isValid = true;
    }
  }

  Object? validateUserData() {
    switch (userSignInEnum) {
      case UserSignInEnum.user:
        return validateName();
      case UserSignInEnum.nickName:
        return validateNickName();
      case UserSignInEnum.email:
        return validateEmail();
      case UserSignInEnum.pronouns:
        isValid = true;
        break;
      default:
        break;
    }
    return null;
  }

  bool get getIsValid => isValid;

  String? validateName() {
    if (!(controller.text).isName) {
      isValid = false;
      return S.current.textErrorEmptyField;
    }
    isValid = true;
    return null;
  }

  String? validateNickName() {
    if (!(controller.text).isNickName) {
      isValid = false;
      return S.current.textErrorUserName;
    }
    isValid = true;
    return null;
  }

  String? validateEmail() {
    if (!(controller.text).isEmail) {
      isValid = false;
      return S.current.textErrorEmail;
    } else if (controller.text.isEmpty) {
      isValid = false;
      return S.current.textErrorEmptyField;
    }
    isValid = true;
    return null;
  }

  String? validatePassword() {
    if (!(controller.text).isPassword) {
      isValid = false;
      return S.current.textErrorLoginPassword;
    } else if (controller.text.isEmpty) {
      isValid = false;
      return S.current.textErrorEmptyField;
    }
    isValid = true;
    return null;
  }

  String? validateConfirmPassword({
    required String currentPassword,
  }) {
    if (controller.text != currentPassword) {
      isValid = false;
      return S.current.textErrorDifferentPasswords;
    }
    isValid = true;
    return null;
  }
}
