import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_loading.dart';

enum Status { loading, completed, error }

class SafeResponse<T> {
  Status status;
  T? data;
  String? message;

  SafeResponse.loading() : status = Status.loading;

  SafeResponse.completed({required this.data}) : status = Status.completed;

  SafeResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \nMessage: $message \nData: $data';
  }
}

//TODO componente incompleto
class SafeBloc extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final Widget? onLoading;
  final Widget? onError;
  final Widget onSuccess;
  final Widget? onEmpty;
  const SafeBloc({
    Key? key,
    required this.snapshot,
    required this.onSuccess,
    this.onLoading = const SafeLoading(),
    this.onError,
    this.onEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _mountBody(context);
  }

  Widget _mountBody(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting ||
        snapshot.data.status == Status.loading) {
      return onLoading!;
    } else if (snapshot.hasError || snapshot.data.status == Status.error) {
      onError ??
          showDialog(
            context: context,
            builder: (context) => SafeDialogs.error(
              message: snapshot.data?.message ?? S.current.textErrorUnknown,
            ),
          );
    } else if (snapshot.hasData || snapshot.data.status == Status.completed) {
      if (snapshot.data.isEmpty) return onEmpty ?? const SizedBox.shrink();
      return onSuccess;
    }
    return const SizedBox.shrink();
  }
}
