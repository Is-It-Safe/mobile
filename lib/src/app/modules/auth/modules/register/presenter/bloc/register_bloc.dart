import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/usecases/is_email_available_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/domain/usecases/is_username_available_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/pages/register_profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/register/presenter/store/register_store.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/terms_and_conditions/presenter/page/terms_and_conditions_page.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/enum/user_sign_in_enum.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

import '../../../../../../../../generated/l10n.dart';

class RegisterBloc extends SafeBloC {
  final RegisterStore store;
  final IsUsernameAvailableUseCase isUsernameAvailableUseCase;
  final IsEmailAvailableUseCase isEmailAvailableUseCase;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterBloc({
    required this.store,
    required this.isUsernameAvailableUseCase,
    required this.isEmailAvailableUseCase,
  });

  @override
  Future<void> init() async {
    SafeLogUtil.instance.route(Modular.to.path);
  }

  void togglePasswordVisibility() {
    store.isPasswordVisible.data = !store.isPasswordVisible.data;
  }

  void toggleConfirmPasswordVisibility() {
    store.isConfirmPasswordVisible.data = !store.isConfirmPasswordVisible.data;
  }

  void toggleRegisterButton(RegisterBloc? bloc) {
    bool isPasswordNotEmpty = bloc!.passwordController.text.isNotEmpty;
    bool isMatchPasswords = bloc.confirmPasswordController.text == bloc.passwordController.text;
    bool isEnabled = !store.listRegisterTextFieldVO.any(
      (element) => element.isValid == false,
    );
    store.isRegisterButtonEnabled.data = isEnabled && isPasswordNotEmpty && isMatchPasswords;
  }

  void toggleTermsAndConditions() {
    store.isTermsAndConditionsChecked.data =
        !store.isTermsAndConditionsChecked.data;
  }

  String? validatePassword(String? value) {
    if (!(value ?? StringConstants.empty).isPassword) {
      return S.current.textErrorLoginPassword;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return S.current.textErrorDifferentPasswords;
    } else if (value?.isEmpty ?? false) {
      return S.current.textErrorEmptyField;
    }
    return null;
  }

  void navigateToTermsAndConditions() {
    Modular.to.push(
      MaterialPageRoute(
        builder: (_) => const TermsAndConditionsPage(),
      ),
    );
  }

  Future<bool> isUsernameAvailable() async {
    store.isUsernameAvailable.loading();

    final username = store.listRegisterTextFieldVO
        .firstWhere((e) => e.userSignInEnum == UserSignInEnum.nickName)
        .controller
        .text;

    final result = await isUsernameAvailableUseCase.call(username: username);

    result.fold(
      (success) {
        store.isUsernameAvailable.data = success;
        if (success == false) {
          safeSnackBar.error('Nome de usuário indisponível');
        }
      },
      (failure) {
        store.isUsernameAvailable.data = false;
        safeSnackBar.error('Nome de usuário indisponível');
      },
    );

    return store.isUsernameAvailable.data;
  }

  Future<bool> isEmailAvailable() async {
    store.isEmailAvailable.loading();

    final email = store.listRegisterTextFieldVO
        .firstWhere((e) => e.userSignInEnum == UserSignInEnum.email)
        .controller
        .text;

    final result = await isEmailAvailableUseCase.call(email: email);

    result.fold(
      (success) {
        store.isEmailAvailable.data = success;
        if (success == false) {
          safeSnackBar.error('Este e-mail já está em uso');
        }
      },
      (failure) {
        store.isEmailAvailable.data = false;
        safeSnackBar.error('Este e-mail já está em uso');
      },
    );

    return store.isEmailAvailable.data;
  }

  Future<void> navigateToRegisterProfile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (await isUsernameAvailable() == false) return;
    if (await isEmailAvailable() == false) return;


    Modular.to.pushNamed(
      StringConstants.dot + RegisterProfilePage.route,
    );
  }

  @override
  Future<void> dispose() async {}
}
