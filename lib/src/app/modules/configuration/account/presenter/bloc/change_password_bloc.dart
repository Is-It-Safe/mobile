import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/entities/request/request_confirm_password.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/change_password_use_case.dart';
import 'package:is_it_safe_app/src/app/modules/auth/domain/usecases/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:result_dart/result_dart.dart';

class ChangePasswordBloC extends SafeBloC {
  final ConfirmPasswordUseCase confirmPasswordUseCase;
  final ChangePasswordUsecase changePasswordUsecase;
  ChangePasswordBloC({
    required this.confirmPasswordUseCase,
    required this.changePasswordUsecase,
  }) {
    init();
  }

  late StreamController<SafeStream<bool>> confirmPasswordController;

  @override
  Future<void> init() async {
    confirmPasswordController = StreamController.broadcast();
  }

  final confirmPasswordText = TextEditingController();

  bool _validated = false;

  bool get validated => _validated;

  confirmPassword({required String password}) async {
    try {
      confirmPasswordController.sink.add(SafeStream.load());
      RequestConfirmPassword request = RequestConfirmPassword(
        password: password,
      );
      await confirmPasswordUseCase.call(request).fold(
        (success) {
          _validated = success;
          confirmPasswordController.sink.add(SafeStream.done(success));
          if (success == false) {
            safeSnackBar.error(S.current.textErrorConfirmPassword);
          }
        },
        (error) {
          safeSnackBar.error(S.current.textErrorConfirmPassword);
        },
      );
      return true;
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
      confirmPasswordController.sink.addError(e.toString());
      return false;
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

  changePassword({required String password}) async {
    final response = await changePasswordUsecase(password: password);
    response.fold((success) {
      safeSnackBar.error(
        S.current.textPasswordSuccessChanged,
      );
    }, (failure) {
      safeSnackBar.error(
        S.current.textPasswordFailureChanged,
      );
    });
  }

  @override
  Future<void> dispose() async {
    confirmPasswordController.close();
  }
}
