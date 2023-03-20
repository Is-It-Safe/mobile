import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/change_password_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_confirm_password.dart';
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

  late StreamController<SafeEvent<bool>> confirmPasswordController;

  @override
  Future<void> init() async {
    confirmPasswordController = StreamController.broadcast();
  }

  final confirmPasswordText = TextEditingController();

  bool _validated = false;

  bool get validated => _validated;

  confirmPassword({required String password}) async {
    try {
      confirmPasswordController.sink.add(SafeEvent.load());
      RequestConfirmPassword request = RequestConfirmPassword(
        password: password,
      );
      await confirmPasswordUseCase.call(request).fold(
        (success) {
          _validated = success;
          confirmPasswordController.sink.add(SafeEvent.done(success));
          if (success == false) {
            _showSnackbarByScaffoldState(
              message: S.current.textErrorConfirmPassword,
              type: SnackBarType.error,
            );
          }
        },
        (error) {
          _showSnackbarByScaffoldState(
            message: S.current.textErrorConfirmPassword,
            type: SnackBarType.error,
          );
        },
      );
      return true;
    } catch (e) {
      SafeLogUtil.instance.logError(e);
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
      _showSnackbarByScaffoldState(
        message: S.current.textPasswordSuccessChanged,
        type: SnackBarType.success,
      );
    }, (failure) {
      _showSnackbarByScaffoldState(
        message: S.current.textPasswordFailureChanged,
        type: SnackBarType.error,
      );
    });
  }

  @override
  Future<void> dispose() async {
    confirmPasswordController.close();
  }

  _showSnackbarByScaffoldState(
      {SnackBarType type = SnackBarType.active, required String message}) {
    final key = Modular.get<GlobalKey<ScaffoldState>>();
    SafeSnackBar(
      message: message,
      type: type,
    ).show(key.currentState!.context);
  }
}
