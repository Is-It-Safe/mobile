import 'package:flutter/material.dart';

import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/vo/register_user_vo.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_text_form_field.dart';
import 'package:is_it_safe_app/src/core/util/user_sign_in_util.dart';

class RegisterTextFormField extends StatelessWidget {
  final RegisterUserVo registerTextFieldVO;
  final bool isPasswordVisible;
  final Function onChanged;
  final Function onValidate;
  final Widget suffixIcon;

  const RegisterTextFormField({
    super.key,
    required this.registerTextFieldVO,
    required this.onChanged,
    required this.onValidate,
    required this.suffixIcon,
    this.isPasswordVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeTextFormField(
      controller: registerTextFieldVO.controller,
      labelText: UserSignInUtil.getCorrectLabelForSignIn(
        userSignInEnum: registerTextFieldVO.userSignInEnum,
      ),
      bottomText: UserSignInUtil.getCorrectBottomTextForSignIn(
        userSignInEnum: registerTextFieldVO.userSignInEnum,
      ),
      obscureText: isPasswordField(),
      onChanged: (_) => onChanged(),
      validator: (_) => onValidate(),
      suffixIcon: suffixIcon,
    );
  }

  bool isPasswordField() {
    if (UserSignInUtil.isObscureFormField(
      userSignInEnum: registerTextFieldVO.userSignInEnum,
    )) {
      return !isPasswordVisible;
    }
    return false;
  }
}
