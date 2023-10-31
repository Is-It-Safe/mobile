// ignore_for_file: overridden_fields

abstract class SafeLocationError {
  final String message;
  SafeLocationError(this.message);
}

class SafeDioResponseLocationError extends SafeLocationError {
  @override
  final String message;

  SafeDioResponseLocationError(this.message) : super(message);
}

class SafeCepError extends SafeLocationError {
  @override
  final String message;

  SafeCepError(this.message) : super(message);
}
