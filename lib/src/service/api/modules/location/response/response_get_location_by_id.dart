import 'response_location_review.dart';

class ResponseGetLocationsById {
  int? id;
  String? name;
  String? endereco;
  String? type;
  String? imgUrl;
  String? averageGrade;
  List<ResponseLocationReview>? reviews;

  ResponseGetLocationsById(
      {this.id,
      this.name,
      this.endereco,
      this.type,
      this.imgUrl,
      this.averageGrade,
      this.reviews});

  factory ResponseGetLocationsById.fromJson(Map<String, dynamic> json) {
    return ResponseGetLocationsById(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      type: json['type'],
      imgUrl: json['imgUrl'],
      averageGrade: json['averageGrade'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((i) => ResponseLocationReview.fromJson(i))
              .toList()
          : null,
    );
  }
}
