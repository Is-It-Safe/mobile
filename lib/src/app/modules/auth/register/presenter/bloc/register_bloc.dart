import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';
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

  void togglePasswordVisibility() {
    store.isPasswordVisible.data = !store.isPasswordVisible.data;
  }

  void toggleRegisterButton() {
    bool isEnabled = !store.registerUserVoList.any(
          (element) => element.isValid == false,
        );
    store.isRegisterButtonEnabled.data = isEnabled;
  }

  void toggleTermsAndConditions() {
    store.isTermsAndConditionsChecked.data =
        !store.isTermsAndConditionsChecked.data;
  }

  String getCurrentPassword() {
    return store.registerUserVoList
        .firstWhere(
            (element) => element.userSignInEnum == UserSignInEnum.password)
        .controller
        .text;
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
