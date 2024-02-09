// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/app/modules/profile/domain/usecases/deactivate_account_use_case.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart' as ss;
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class DeactivateAccountBloc extends SafeBloC {
  final deactivateAccountStream = ss.SafeStream<bool?>(data: null);

  final DeactivateAccountUseCase deactivateAccountUseCase;

  DeactivateAccountBloc(this.deactivateAccountUseCase);

  @override
  Future<void> init() async {
    deactivateAccountStream.initial();
  }

  Future<void> deactivateAccount() async {
    final context = Modular.get<GlobalKey<ScaffoldState>>().currentContext!;

    try {
      if (!context.mounted) return;
      final response = await deactivateAccountUseCase();
      response.fold(
        (success) {
          SafeSnackBar().success(S.of(context).textDeactivatedAccountSuccess);
          Modular.to.navigate(LoginPage.route);
        },
        (failure) {
          deactivateAccountStream.error(failure.message);
          SafeSnackBar().error(S.of(context).textNotPossibleDeativateAccount);
        },
      );
    } catch (e, stackTrace) {
      Catcher2.reportCheckedError(e, stackTrace);
      deactivateAccountStream.error(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    deactivateAccountStream.hide();
  }
}
