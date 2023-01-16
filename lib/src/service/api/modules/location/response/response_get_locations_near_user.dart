import 'response_location_review.dart';

class ResponseGetLocationsNearUser {
  int? id;
  String? name;
  String? endereco;
  String? type;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;
  List<ResponseLocationReview>? reviews;
  ResponseGetLocationsNearUser({
    this.id,
    this.name,
    this.endereco,
    this.type,
    this.imgUrl,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.reviews,
  });

  factory ResponseGetLocationsNearUser.fromJson(Map<String, dynamic> json) {
    return ResponseGetLocationsNearUser(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      type: json['type'],
      imgUrl: json['imgUrl'],
      averageGrade: json['averageGrade'],
      reviewsQnt: json['reviewsQnt'],
      averageImpressionStatus: json['averageImpressionStatus'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
              .map((i) => ResponseLocationReview.fromJson(i))
              .toList()
          : null,
    );
  }
}
