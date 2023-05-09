// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart' as ss;
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';
import 'package:is_it_safe_app/src/core/util/validation_util.dart';
import 'package:is_it_safe_app/src/domain/use_case/get_user_email_use_case.dart';
import 'package:is_it_safe_app/src/domain/use_case/save_user_email_use_case.dart';

class ChangeEmailBloc extends SafeBloC {
  final GetUserEmailUsecase getUserEmailUsecase;
  final SaveUserEmailUsecase saveUserEmailUsecase;

  final changeEmailStream = ss.SafeStream<bool?>(data: null);
  final getEmailStream = ss.SafeStream<String?>(data: null);

  ChangeEmailBloc(
    this.getUserEmailUsecase,
    this.saveUserEmailUsecase,
  );

  final emailAddressText = TextEditingController();

  @override
  Future<void> init() async {
    //
  }

  bool get emailValidated => ValidationUtil.email(emailAddressText.text);

  String validateEmail({
    required String? value,
  }) {
    if (!ValidationUtil.email(value ?? StringConstants.empty)) {
      final context = Modular.get<GlobalKey<ScaffoldState>>().currentContext!;
      S.of(context).textErrorEmail;
    }
    return StringConstants.empty;
  }

  Future<void> getUserEmail() async {
    try {
      getEmailStream.loading();
      await getUserEmailUsecase.call().then((email) {
        getEmailStream.data = email;
      });
    } catch (e) {
      getEmailStream.error(e.toString());
    }
  }

  Future<void> _saveUserEmail(String value) async {
    try {
      await saveUserEmailUsecase.call(userEmail: value);
    } catch (e, stacktrace) {
      SafeLogUtil.instance.logError(e);
      Catcher.reportCheckedError(e, stacktrace);
    }
  }

  Future<void> changeUserEmail(String email) async {
    await _saveUserEmail(email);
  }

  @override
  Future<void> dispose() async {
    changeEmailStream.hide();
    getEmailStream.hide();
  }
}
