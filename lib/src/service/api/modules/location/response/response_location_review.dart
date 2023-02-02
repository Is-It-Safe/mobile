class ResponseLocationReview {
  final int? id;
  final String? author;
  final String? review;
  final String? createdAt;
  final double? myGrade;

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
