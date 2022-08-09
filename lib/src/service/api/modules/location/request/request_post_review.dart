class RequestReview {
  String? review;
  int? grade;
  String? impressionStatus;
  int? locationId;

  RequestReview({
    this.review,
    this.grade,
    this.impressionStatus,
    this.locationId,
  });

  Map<String, dynamic> toJson(RequestReview request) {
    return {
      'review': request.review,
      'grade': request.grade,
      'impression_status': request.impressionStatus,
      'location_id': request.locationId,
    };
  }
}
