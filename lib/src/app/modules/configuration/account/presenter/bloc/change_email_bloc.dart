// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';

class ChangeEmailBloc extends SafeBloC {
  ChangeEmailBloc() {
    init();
  }

  late StreamController<SafeEvent<bool>> changeEmailController;

  final emailAddressText = TextEditingController();

  @override
  Future<void> init() async {
    changeEmailController = StreamController.broadcast();
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

  @override
  Future<void> dispose() async {}
}
