class ResponseLocationReview {
  int? id;
  String? author;
  String? review;
  String? createdAt;
  double? myGrade;

  ResponseLocationReview({
    this.id,
    this.author,
    this.review,
    this.createdAt,
    this.myGrade,
  });

  factory ResponseLocationReview.fromJson(Map<String, dynamic> json) {
    return ResponseLocationReview(
      id: json['id'],
      author: json['author'],
      review: json['review'],
      createdAt: json['createdAt'],
      myGrade: json['myGrade'],
    );
  }
}
