import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';

class SafeLayout {
  final AsyncSnapshot<SafeEvent<dynamic>> snapshot;
  final BuildContext context;
  final bool showErrorDialog;
  final Future<dynamic> Function()? doOnCompleted;
  final Widget onLoading;
  final Widget onError;
  final Widget onCompleted;
  final Widget onEmpty;
  final Widget onInitial;

  SafeLayout({
    required this.snapshot,
    required this.context,
    required this.onCompleted,
    this.doOnCompleted,
    this.showErrorDialog = true,
    this.onLoading = const SafeLoading(),
    this.onEmpty = const SizedBox.shrink(),
    this.onInitial = const SizedBox.shrink(),
    this.onError = const SizedBox.shrink(),
  });

  Widget get build {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return onInitial;
      case ConnectionState.waiting:
        return _onWaiting();
      case ConnectionState.active:
        return _onDone();
      case ConnectionState.done:
        return _onDone();
      default:
        return onInitial;
    }
  }

  Widget _onWaiting() {
    if (snapshot.data?.status == Status.initial) {
      return onInitial;
    } else {
      return onLoading;
    }
  }

  Widget _onDone() {
    if (snapshot.hasError) {
      if (showErrorDialog) {
        Future.delayed(Duration.zero, () async {
          showDialog(
            context: context,
            builder: (context) => SafeDialog(
              message: snapshot.error.toString(),
              primaryBtn: SafeButton(
                title: S.current.textOk,
              ),
              type: SafeDialogType.error,
              // onTap: () => Navigator.pop(context),
            ),
          );
        });
      }
      return onError;
    } else {
      switch (snapshot.data?.status) {
        case Status.initial:
          return onInitial;
        case Status.loading:
          return onLoading;
        case Status.done:
          if (_checkIfListIsNotEmpty() || _checkIfDataIsNotEmpty()) {
            if (doOnCompleted != null) doOnCompleted!();
            return onCompleted;
          }
          return onEmpty;
        default:
          return onInitial;
      }
    }
  }

  bool _checkIfListIsNotEmpty() {
    if (snapshot.data?.data is List) {
      if (snapshot.data?.data.isEmpty) return false;
    }
    return true;
  }

  bool _checkIfDataIsNotEmpty() {
    if (snapshot.data?.data != null) {
      if (snapshot.data?.data.isEmpty) return false;
    }
    return true;
  }
}
