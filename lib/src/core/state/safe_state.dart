import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_bloc.dart';
import 'package:is_it_safe_app/src/core/state/focus_detector.dart';

abstract class SafeState<V extends StatefulWidget, C extends SafeBloC>
    extends State<V> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static T get<T extends Object>({T? defaultValue}) {
    return Modular.get<T>(defaultValue: defaultValue);
  }

  late C bloc;
  bool isExecuteInit = true;
  bool performFocusActions = false;

  void beforeInit() {}

  @override
  void initState() {
    super.initState();
    bloc = SafeState.get<C>();
    beforeInit();
    if (isExecuteInit) {
      Future.delayed(Duration.zero, () async {
        await bloc.init();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => performFocusActions = true,
        );
      });
    } else {
      performFocusActions = true;
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FocusDetector(
      onFocusGained: () {
        if (performFocusActions) {
          bloc.onFocusGained();
        }
      },
      onFocusLost: () {
        if (performFocusActions) {
          bloc.onFocusLost();
        }
      },
      onForegroundGained: () {
        if (performFocusActions) {
          bloc.onForegroundGained();
        }
      },
      onForegroundLost: () {
        if (performFocusActions) {
          bloc.onForegroundLost();
        }
      },
      onVisibilityGained: () {
        if (performFocusActions) {
          bloc.onVisibilityGained();
        }
      },
      onVisibilityLost: () {
        if (performFocusActions) {
          bloc.onVisibilityLost();
        }
      },
      child: buildDetector(context),
    );
  }

  Widget buildDetector(BuildContext context) {
    return super.build(context);
  }
}
