import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/core/state/safe_observer.dart';
import 'package:is_it_safe_app/src/core/state/safe_status.dart';
import 'package:is_it_safe_app/src/core/state/safe_stream.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class _SafeBuilder0<A, B, C, D, E> extends StatefulWidget {
  final SafeStream<A> stream1;
  final SafeStream<B> stream2;
  final SafeStream<C> stream3;
  final SafeStream<D> stream4;
  final SafeStream<E> stream5;

  final Widget Function(
    A value1,
    B value2,
    C value3,
    D value4,
    E value5,
  ) builder;
  late final Widget Function() onLoading;
  late final Widget Function(String message) onError;
  late final Widget Function(Widget child) onUnauthorized;
  late final Widget Function() onInitial;

  _SafeBuilder0({
    super.key,
    required this.stream1,
    required this.stream2,
    required this.stream3,
    required this.stream4,
    required this.stream5,
    required this.builder,
    Widget Function()? onLoading,
    Widget Function(String message)? onError,
    Widget Function(Widget child)? onUnauthorized,
    Widget Function()? onInitial,
  }) {
    this.onLoading = onLoading ?? () => const Center(child: SafeLoading());

    this.onError = onError ?? (_) => const SizedBox.shrink();

    this.onUnauthorized = onUnauthorized ?? (child) => const SizedBox.shrink();

    this.onInitial = onInitial ?? () => const SizedBox.shrink();
  }

  @override
  _SafeBuilder0State<A, B, C, D, E> createState() =>
      _SafeBuilder0State<A, B, C, D, E>();
}

class _SafeBuilder0State<A, B, C, D, E>
    extends State<_SafeBuilder0<A, B, C, D, E>> implements SafeObserver {
  late Widget buildWidget;

  @override
  void initState() {
    buildWidget = const SizedBox.shrink();
    widget.stream1.addObserver(this);
    widget.stream2.addObserver(this);
    widget.stream3.addObserver(this);
    widget.stream4.addObserver(this);
    widget.stream5.addObserver(this);
    super.initState();
    notifyState();
  }

  @override
  Widget build(BuildContext context) => buildWidget;

  @override
  void notifyState() => setState(() => _selectState());

  void _selectState() {
    final listStates = <SafeStatus?>[
      widget.stream1.status,
      widget.stream2.status,
      widget.stream3.status,
      widget.stream4.status,
      widget.stream5.status,
    ];

    if (listStates.contains(SafeStatus.error)) {
      final message = widget.stream1.alertMessage ??
          widget.stream2.alertMessage ??
          widget.stream3.alertMessage ??
          widget.stream4.alertMessage ??
          widget.stream5.alertMessage;
      buildWidget = widget.onError(message ?? StringConstants.empty);
    } else if (listStates.contains(SafeStatus.hidden)) {
      buildWidget = const SizedBox.shrink();
    } else if (listStates.contains(SafeStatus.loading)) {
      buildWidget = widget.onLoading();
    } else if (listStates.contains(SafeStatus.unAuthorized)) {
    } else if (listStates.contains(SafeStatus.initial)) {
      buildWidget = widget.onInitial();
    } else {
      buildWidget = widget.builder(
        widget.stream1.data,
        widget.stream2.data,
        widget.stream3.data,
        widget.stream4.data,
        widget.stream5.data,
      );
    }
  }

  @override
  void dispose() {
    widget.stream1.removeObserver(this);
    widget.stream2.removeObserver(this);
    widget.stream3.removeObserver(this);
    widget.stream4.removeObserver(this);
    widget.stream5.removeObserver(this);
    super.dispose();
  }
}

class SafeBuilder<A>
    extends _SafeBuilder0<A, dynamic, dynamic, dynamic, dynamic> {
  SafeBuilder({
    super.key,
    required SafeStream<A> stream,
    required Widget Function(A value1) builder,
    super.onLoading,
    super.onError,
    super.onUnauthorized,
    super.onInitial,
  }) : super(
          stream1: stream,
          stream2: SafeStream<dynamic>(data: null, ignore: true),
          stream3: SafeStream<dynamic>(data: null, ignore: true),
          stream4: SafeStream<dynamic>(data: null, ignore: true),
          stream5: SafeStream<dynamic>(data: null, ignore: true),
          builder: (A value1, value2, value3, value4, value5) {
            return builder(value1);
          },
        );
}

class SafeBuilder2<A, B>
    extends _SafeBuilder0<A, B, dynamic, dynamic, dynamic> {
  SafeBuilder2({
    super.key,
    required super.stream1,
    required super.stream2,
    required Widget Function(A value1, B value2) builder,
    super.onLoading,
    super.onError,
    super.onUnauthorized,
    super.onInitial,
  }) : super(
          stream3: SafeStream<dynamic>(data: null, ignore: true),
          stream4: SafeStream<dynamic>(data: null, ignore: true),
          stream5: SafeStream<dynamic>(data: null, ignore: true),
          builder: (A value1, B value2, value3, value4, value5) {
            return builder(value1, value2);
          },
        );
}

class SafeBuilder3<A, B, C> extends _SafeBuilder0<A, B, C, dynamic, dynamic> {
  SafeBuilder3({
    super.key,
    required super.stream1,
    required super.stream2,
    required super.stream3,
    required Widget Function(A value1, B value2, C value3) builder,
    super.onLoading,
    super.onError,
    super.onUnauthorized,
    super.onInitial,
  }) : super(
          stream4: SafeStream<dynamic>(data: null, ignore: true),
          stream5: SafeStream<dynamic>(data: null, ignore: true),
          builder: (A value1, B value2, C value3, value4, value5) {
            return builder(value1, value2, value3);
          },
        );
}

class SafeBuilder4<A, B, C, D> extends _SafeBuilder0<A, B, C, D, dynamic> {
  SafeBuilder4({
    super.key,
    required super.stream1,
    required super.stream2,
    required super.stream3,
    required super.stream4,
    required Widget Function(A value1, B value2, C value3, D value4) builder,
    super.onLoading,
    super.onError,
    super.onUnauthorized,
    super.onInitial,
  }) : super(
          stream5: SafeStream<dynamic>(data: null, ignore: true),
          builder: (A value1, B value2, C value3, D value4, value5) {
            return builder(value1, value2, value3, value4);
          },
        );
}

class VmSelector5<A, B, C, D, E> extends _SafeBuilder0<A, B, C, D, E> {
  VmSelector5({
    super.key,
    required super.stream1,
    required super.stream2,
    required super.stream3,
    required super.stream4,
    required super.stream5,
    required Widget Function(A value1, B value2, C value3, D value4, E value5)
        builder,
    super.onLoading,
    super.onError,
    super.onUnauthorized,
    super.onInitial,
  }) : super(
          builder: (A value1, B value2, C value3, D value4, E value5) {
            return builder(value1, value2, value3, value4, value5);
          },
        );
}
