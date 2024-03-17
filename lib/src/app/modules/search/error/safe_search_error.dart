abstract class SafeSearchError {
  final String message;

  SafeSearchError(this.message);
}

class SafeDioResponseSearchError extends SafeSearchError {
  SafeDioResponseSearchError(String message) : super(message);
}
