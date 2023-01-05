import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';

class SafeLayout extends StatelessWidget {
  final AsyncSnapshot<SafeEvent<dynamic>> snapshot;
  final bool showErrorDialog;
  final Future<dynamic> Function()? doOnCompleted;
  final Widget onLoading;
  final Widget onError;
  final Widget onCompleted;
  final Widget onEmpty;
  final Widget onInitial;

  const SafeLayout({
    Key? key,
    required this.snapshot,
    required this.onCompleted,
    this.doOnCompleted,
    this.showErrorDialog = true,
    this.onLoading = const SafeLoading(),
    this.onEmpty = const SizedBox.shrink(),
    this.onInitial = const SizedBox.shrink(),
    this.onError = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return onInitial;
      case ConnectionState.waiting:
        return _OnWaiting(
          snapshot: snapshot,
          onInitial: onInitial,
          onLoading: onLoading,
        );
      case ConnectionState.active:
        return _OnDone(
            snapshot: snapshot,
            onInitial: onInitial,
            onLoading: onLoading,
            doOnCompleted: doOnCompleted,
            onError: onError,
            onCompleted: onCompleted,
            showErrorDialog: showErrorDialog,
            onEmpty: onEmpty);
      case ConnectionState.done:
        return _OnDone(
          snapshot: snapshot,
          onInitial: onInitial,
          onLoading: onLoading,
          doOnCompleted: doOnCompleted,
          onError: onError,
          onCompleted: onCompleted,
          showErrorDialog: showErrorDialog,
          onEmpty: onEmpty,
        );
      default:
        return onInitial;
    }
  }
}

class _OnWaiting extends StatelessWidget {
  final AsyncSnapshot<SafeEvent<dynamic>> snapshot;
  final Widget onInitial;
  final Widget onLoading;
  const _OnWaiting(
      {Key? key,
      required this.snapshot,
      required this.onInitial,
      required this.onLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data?.status == Status.initial) {
      return onInitial;
    } else {
      return onLoading;
    }
  }
}

class _OnDone extends StatelessWidget {
  final AsyncSnapshot<SafeEvent<dynamic>> snapshot;
  final Widget onInitial;
  final Widget onLoading;
  final Future<dynamic> Function()? doOnCompleted;
  final Widget onError;
  final Widget onEmpty;
  final Widget onCompleted;
  final bool showErrorDialog;
  const _OnDone({
    Key? key,
    required this.snapshot,
    required this.onInitial,
    required this.onLoading,
    required this.doOnCompleted,
    required this.onError,
    required this.onCompleted,
    required this.showErrorDialog,
    required this.onEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      return snapshot.data?.data.isNotEmpty;
    }
    return true;
  }

  bool _checkIfDataIsNotEmpty() {
    if (snapshot.data?.data != null) {
      return snapshot.data?.data.isNotEmpty;
    }
    return true;
  }
}
