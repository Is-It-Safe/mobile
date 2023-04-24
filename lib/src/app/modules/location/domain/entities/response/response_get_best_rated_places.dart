import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_location_review.dart';

class ResponseGetRatedPlaces {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;
  final List<ResponseLocationReview>? reviews;

  ResponseGetRatedPlaces({
    this.id,
    this.name,
    this.endereco,
    this.imgUrl,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.reviews,
  });

  factory ResponseGetRatedPlaces.fromJson(Map<String, dynamic> json) {
    return ResponseGetRatedPlaces(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      imgUrl: json['imgUrl'],
      averageGrade: json['averageGrade'],
      averageImpressionStatus: json['averageImpressionStatus'],
      reviewsQnt: json['reviewsQnt'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((i) => ResponseLocationReview.fromJson(i))
              .toList()
          : null,
    );
  }
}
