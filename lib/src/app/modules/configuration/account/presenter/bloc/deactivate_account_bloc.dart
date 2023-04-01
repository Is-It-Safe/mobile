import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/auth/login/presenter/pages/login_page.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_snack_bar.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart' as ss;
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';

class DeactivateAccountBloc extends SafeBloC {
  final deactivateAccountStream = ss.SafeStream<bool?>(data: null);

  @override
  Future<void> init() async {
    //
  }

  Future<void> deactivateAccount() async {
    final context = Modular.get<GlobalKey<ScaffoldState>>().currentContext!;

    // TODO: Integrar com endpoint de desativar conta quando estiver pronto

    try {
      SafeSnackBar().success(S.of(context).textDeactivatedAccountSuccess);
      Modular.to.navigate(LoginPage.route);
    } catch (e) {
      SafeSnackBar().error(S.of(context).textNotPossibleDeativateAccount);
    }
  }

  @override
  Future<void> dispose() async {
    //
  }
}
