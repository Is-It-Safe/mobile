import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/extentions/validation_extentions.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/confirm_password_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/request/request_confirm_password.dart';
import 'package:result_dart/result_dart.dart';

class ChangePasswordBloC extends SafeBloC {
  final ConfirmPasswordUseCase confirmPasswordUseCase;
  ChangePasswordBloC({
    required this.confirmPasswordUseCase,
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
        },
        (error) {},
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

  @override
  Future<void> dispose() async {
    throw UnimplementedError();
  }
}
