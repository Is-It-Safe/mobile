import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/pages/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class RegisterBloc extends SafeBloC {
  final RegisterStore store;

  RegisterBloc({
    required this.store,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  void tooglePasswordVisibility() {
    store.isPassowordVisible.data = !store.isPassowordVisible.data;
  }

  void toogleRegisterButton() {
    bool isEnabled = (store.nameTextController.text.isNotEmpty &&
        store.usernameTextController.text.isNotEmpty &&
        store.emailTextController.text.isNotEmpty &&
        store.passwordTextController.text.isNotEmpty &&
        store.confirmPasswordTextController.text.isNotEmpty &&
        store.isTermsAndConditionsChecked.data);
    store.isRegisterButtonEnabled.data = isEnabled;
  }

  String? validateName(String? value) {
    if (!(value ?? StringConstants.empty).isName) {
      return S.current.textErrorEmptyField;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (!(value ?? StringConstants.empty).isEmail) {
      return S.current.textErrorEmail;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  String? validatePassword(
    String? value, {
    String? errorText,
  }) {
    if (!(value ?? StringConstants.empty).isPassword) {
      return errorText ?? S.current.textErrorLoginPassword;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  void toogleTermsAndConditions() {
    store.isTermsAndConditionsChecked.data =
        !store.isTermsAndConditionsChecked.data;
  }

  void navigateToTermsAndConditions() {
    Modular.to.push(
      MaterialPageRoute(
        builder: (_) => const TermsAndConditionsPage(),
      ),
    );
  }

  @override
  Future<void> dispose() async {}
}
