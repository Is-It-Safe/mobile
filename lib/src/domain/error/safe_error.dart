// ignore_for_file: overridden_fields

abstract class SafeError {
  final String message;

  SafeError(this.message);
}

class SafeInvalidCredentialsError extends SafeError {
  @override
  final String message;

  SafeInvalidCredentialsError(this.message) : super(message);
}

class SafeExceptionsCatchedError extends SafeError {
  @override
  final String message;

  SafeExceptionsCatchedError(this.message) : super(message);
}

class SafeDioResponseError extends SafeError {
  @override
  final String message;

  SafeDioResponseError(this.message) : super(message);
}
