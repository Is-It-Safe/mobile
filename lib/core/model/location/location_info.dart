class Location {
  late int id;
  late String name;
  late String endereco;
  late double averageGrade;
  late int reviewsQnt;
  String? imgUrl;

  Location({
    required this.id,
    required this.name,
    required this.endereco,
    required this.averageGrade,
    required this.reviewsQnt,
    this.imgUrl,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    endereco = json['endereco'];
    imgUrl = json['imgUrl'];
    averageGrade = json['averageGrade'];
    reviewsQnt = json['reviewsQnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['endereco'] = endereco;
    data['imgUrl'] = imgUrl;
    data['averageGrade'] = averageGrade;
    data['reviewsQnt'] = reviewsQnt;
    return data;
  }
}
