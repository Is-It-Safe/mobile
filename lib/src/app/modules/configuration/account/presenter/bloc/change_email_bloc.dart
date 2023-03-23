// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_email_use_case.dart';

class ChangeEmailBloc extends SafeBloC {
  final GetUserEmailUsecase getUserEmailUsecase;

  ChangeEmailBloc(
    this.getUserEmailUsecase,
  ) {
    init();
  }

  late StreamController<SafeEvent<bool>> changeEmailController;
  late StreamController<SafeEvent<String>> getEmailController;

  final emailAddressText = TextEditingController();

  @override
  Future<void> init() async {
    changeEmailController = StreamController.broadcast();
    getEmailController = StreamController.broadcast();
  }

  bool get emailValidated => !ValidationUtil.email(emailAddressText.text);

  String validateEmail(
    BuildContext context, {
    required String? value,
  }) {
    if (!ValidationUtil.email(value ?? StringConstants.empty)) {
      S.of(context).textErrorEmail;
    }
    return StringConstants.empty;
  }

  Future<void> getUserEmail() async {
    try {
      getEmailController.sink.add(SafeEvent.load());
      await getUserEmailUsecase.call().then((email) {
        getEmailController.sink.add(SafeEvent.done(email));
      });
    } catch (e) {
      getEmailController.addError(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    changeEmailController.close();
    getEmailController.close();
  }
}
