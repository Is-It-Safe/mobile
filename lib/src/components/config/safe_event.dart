@Deprecated('Use SafeState with SafeStream instead.')
enum Status { loading, done, error, initial }

@Deprecated('Use SafeStream with SafeState instead.')
class SafeStream<T> {
  Status status;
  T? data;
  String? message;

  SafeStream.initial() : status = Status.initial;

  SafeStream.load() : status = Status.loading;

  SafeStream.done(this.data) : status = Status.done;

  @Deprecated('Use yourController.addError(yourErrorMessage);')
  SafeStream.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status: $status \nMessage: $message \nData: $data';
  }
}
