class RequestSaveReview {
  String? review;
  int? grade;
  String? impressionStatus;
  int? locationId;

  RequestSaveReview({
    this.review,
    this.grade,
    this.impressionStatus,
    this.locationId,
  });

  Map<String, dynamic> toJson(RequestSaveReview request) {
    return {
      'review': request.review,
      'grade': request.grade,
      'impression_status': request.impressionStatus,
      'location_id': request.locationId,
    };
  }
}
