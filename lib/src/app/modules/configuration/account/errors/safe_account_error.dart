abstract class SafeAccountError {
  final String message;

  SafeAccountError(this.message);
}

class SafeDioResponseAccountError extends SafeAccountError {
  SafeDioResponseAccountError(String message) : super(message);
}
