import 'package:flutter/material.dart';

enum Status { loading, completed, error }

class StreamResponse<T> {
  Status status;
  T? data;
  String? message;

  StreamResponse.loading() : status = Status.loading;

  StreamResponse.completed({required this.data}) : status = Status.completed;

  StreamResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \nMessage: $message \nData: $data';
  }
}

//TODO componente incompleto
class StatusResponse extends StatelessWidget {
  final Status status;
  final Function() onCompleted;
  final Function() onLoading;
  final Function(String) onError;
  final Function()? onDefault;
  const StatusResponse({
    Key? key,
    required this.status,
    required this.onCompleted,
    required this.onLoading,
    required this.onError,
    this.onDefault,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.completed:
        return onCompleted();
      case Status.loading:
        return onLoading();
      case Status.error:
        //TODO show error dialog/snackbar
        return onError('');
      default:
        return onDefault!() ?? Container();
    }
  }
}
