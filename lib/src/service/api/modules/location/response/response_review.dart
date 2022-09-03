class ResponseReview {
  int? id;
  String? author;
  String? review;
  String? createdAt;
  double? myGrade;

  ResponseReview({
    this.id,
    this.author,
    this.review,
    this.createdAt,
    this.myGrade,
  });

  factory ResponseReview.fromJson(Map<String, dynamic> json) {
    return ResponseReview(
      id: json['id'],
      author: json['author'],
      review: json['review'],
      createdAt: json['createdAt'],
      myGrade: json['myGrade'],
    );
  }
}
