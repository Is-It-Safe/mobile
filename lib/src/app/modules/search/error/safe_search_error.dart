abstract class SafeSearchError {
  final String message;

  SafeSearchError(this.message);
}

class SafeDioResponseSearchError extends SafeSearchError {
  @override
  final String message;

  SafeDioResponseSearchError(this.message) : super(message);
}
