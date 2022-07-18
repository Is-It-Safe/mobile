class Reviews {
  int? id;
  String? author;
  String? review;
  String? createdAt;
  double? myGrade;

  Reviews({this.id, this.author, this.review, this.createdAt, this.myGrade});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    review = json['review'];
    createdAt = json['createdAt'];
    myGrade = json['myGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['review'] = this.review;
    data['createdAt'] = this.createdAt;
    data['myGrade'] = this.myGrade;
    return data;
  }
}