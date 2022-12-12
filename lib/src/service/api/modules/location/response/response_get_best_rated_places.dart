class ResponseGetRatedPlaces {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;

  ResponseGetRatedPlaces(
      {this.id,
      this.name,
      this.endereco,
      this.imgUrl,
      this.averageGrade,
      this.averageImpressionStatus,
      this.reviewsQnt});

  factory ResponseGetRatedPlaces.fromJson(Map<String, dynamic> json) {
    return ResponseGetRatedPlaces(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      imgUrl: json['imgUrl'],
      averageGrade: json['averageGrade'],
      averageImpressionStatus: json['averageImpressionStatus'],
      reviewsQnt: json['reviewsQnt'],
    );
  }
}
