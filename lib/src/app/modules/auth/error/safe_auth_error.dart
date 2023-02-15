// ignore_for_file: overridden_fields

abstract class SafeAuthError {
  final String message;

  SafeAuthError(this.message);
}

class SafeInvalidCredentialsError extends SafeAuthError {
  @override
  final String message;

  SafeInvalidCredentialsError(this.message) : super(message);
}

class SafeExceptionsCatchedError extends SafeAuthError {
  @override
  final String message;

  SafeExceptionsCatchedError(this.message) : super(message);
}

class SafeDioResponseError extends SafeAuthError {
  @override
  final String message;

  SafeDioResponseError(this.message) : super(message);
}
