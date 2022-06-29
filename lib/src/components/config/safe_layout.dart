import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/config/safe_event.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';

class SafeLayout {
  final AsyncSnapshot<SafeEvent<dynamic>> snapshot;
  final Widget onLoading;
  final Widget? onError;
  final Widget onCompleted;
  final Widget onEmpty;
  final Widget onInitial;

  SafeLayout({
    required this.snapshot,
    required this.onCompleted,
    this.onLoading = const SafeLoading(),
    this.onEmpty = const SizedBox.shrink(),
    this.onInitial = const SizedBox.shrink(),
    this.onError,
  });

  Widget get build {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return onInitial;
      case ConnectionState.waiting:
        return onLoading;
      case ConnectionState.active:
        return _onDone();
      case ConnectionState.done:
        return _onDone();
      default:
        return onInitial;
    }
  }

  Widget _onDone() {
    if (snapshot.hasError) {
      return onError ??
          SafeDialogs.error(
            message: snapshot.error.toString(),
          );
    }
    if (!snapshot.hasData) {
      return onEmpty;
    }
    return onCompleted;
  }
}
