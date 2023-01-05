import 'package:is_it_safe_app/src/service/api/modules/location/response/response_location_review.dart';

class ResponseGetRatedPlaces {
  int? id;
  String? name;
  String? endereco;
  String? imgUrl;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;
  ResponseLocationReview? review;
  int? reviewId;
  String? reviewReview;
  String? reviewAuthor;
  String? reviewCreatedAt;

  ResponseGetRatedPlaces({
    this.id,
    this.name,
    this.endereco,
    this.imgUrl,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.review,
    this.reviewId,
    this.reviewReview,
    this.reviewAuthor,
    this.reviewCreatedAt,
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
      review: json['review'],
      reviewId: json['reviewId'],
      reviewReview: json['reviewReview'],
      reviewAuthor: json['reviewAuthor'],
      reviewCreatedAt: json['reviewCreatedAt'],
    );
  }
}
