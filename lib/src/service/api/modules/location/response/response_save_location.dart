class ResponseSaveLocation {
  int? id;
  String? name;
  String? endereco;
  String? averageGrade;
  String? reviewsQnt;
  String? imgUrl;
  String? averageImpressionStatus;

  ResponseSaveLocation({
    this.id,
    this.name,
    this.endereco,
    this.averageGrade,
    this.reviewsQnt,
    this.imgUrl,
    this.averageImpressionStatus,
  });

  factory ResponseSaveLocation.fromJson(dynamic json) {
    return ResponseSaveLocation(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      averageGrade: json['averageGrade'],
      reviewsQnt: json['reviewsQnt'],
      imgUrl: json['imgUrl'],
      averageImpressionStatus: json['averageImpressionStatus'],
    );
  }
}
