class LocalReview {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  String? averageGrade;
  int? reviewsQnt;

  LocalReview(
      {this.id,
      this.name,
      this.endereco,
      this.imgUrl,
      this.averageGrade,
      this.reviewsQnt});

  LocalReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
    averageGrade = json['averageGrade'];
    reviewsQnt = json['reviewsQnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['endereco'] = this.endereco;
    data['imgUrl'] = this.imgUrl;
    data['averageGrade'] = this.averageGrade;
    data['reviewsQnt'] = this.reviewsQnt;
    return data;
  }
}
