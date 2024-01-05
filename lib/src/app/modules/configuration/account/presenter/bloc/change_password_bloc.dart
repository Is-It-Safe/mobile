import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/change_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/change_password_page.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class ChangePasswordBloC extends SafeBloC {
  final ConfirmPasswordUseCase confirmPasswordUseCase;
  final ChangePasswordUsecase changePasswordUsecase;

  final isPasswordValid = SafeStream<bool>(data: false);

  ChangePasswordBloC({
    required this.confirmPasswordUseCase,
    required this.changePasswordUsecase,
  });

  @override
  Future<void> init() async {}

  final confirmPasswordText = TextEditingController();

  Future<void> confirmPassword({required String password}) async {
    isPasswordValid.loading();
    try {
      RequestConfirmPassword request = RequestConfirmPassword(
        password: password,
      );
      final result = await confirmPasswordUseCase.call(request);
      result.fold(
        (success) {
          isPasswordValid.data = success;
          if (success == false) {
            throw Exception(S.current.textErrorConfirmPassword);
          }
        },
        (error) => throw Exception(S.current.textErrorConfirmPassword),
      );
    } catch (e, stacktrace) {
      isPasswordValid.show();
      SafeLogUtil.instance.logError(e);
      Catcher2.reportCheckedError(e, stacktrace);
      isPasswordValid.error(e.toString());
      safeSnackBar.error(e.toString());
    }
  }

  final newPasswordText = TextEditingController();
  final confirmNewPasswordText = TextEditingController();

  bool get validateNewPassword {
    return ((newPasswordText.text.isNotEmpty &&
            confirmNewPasswordText.text.isNotEmpty) &&
        (newPasswordText.text.isPassword &&
            confirmNewPasswordText.text.isPassword) &&
        (newPasswordText.text == confirmNewPasswordText.text));
  }

  Future<void> changePassword({required String password}) async {
    final response = await changePasswordUsecase(password: password);
    response.fold(
      (success) => safeSnackBar.success(S.current.textPasswordSuccessChanged),
      (failure) => safeSnackBar.error(S.current.textPasswordFailureChanged),
    );
  }

  void navigateToChangePassword() {
    Modular.to.pushNamed('././.${ChangePasswordPage.route}');
  }

  @override
  Future<void> dispose() async {
    isPasswordValid.data = false;
  }
}
