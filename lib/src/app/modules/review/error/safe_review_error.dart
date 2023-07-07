// ignore_for_file: overridden_fields

abstract class SafeReviewError {
  final String message;

  SafeReviewError(this.message);
}

class SafeDioResponseReviewError extends SafeReviewError {
  @override
  final String message;

  SafeDioResponseReviewError(this.message) : super(message);
}
