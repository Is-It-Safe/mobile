class RequestSaveReview {
  String review;
  int grade;
  String impressionStatus;
  int locationId;

  RequestSaveReview({
    required this.review,
    required this.grade,
    required this.impressionStatus,
    required this.locationId,
  });

  Map<String, dynamic> toJson(RequestSaveReview request) {
    return {
      'review': request.review,
      'grade': request.grade,
      'impressionStatus': request.impressionStatus,
      'location_id': request.locationId,
    };
  }
}
