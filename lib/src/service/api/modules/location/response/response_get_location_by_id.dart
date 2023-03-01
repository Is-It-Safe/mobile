import 'response_location_review.dart';

class ResponseGetLocationsById {
  final int? id;
  final String? name;
  final String? endereco;
  final String? type;
  final String? imgUrl;
  final String? averageImpressionStatus;
  final double? averageGrade;
  final int? reviewsQnt;
  final List<ResponseLocationReview>? reviews;

  ResponseGetLocationsById(
      {this.id,
      this.name,
      this.endereco,
      this.type,
      this.imgUrl,
      this.averageGrade,
      this.averageImpressionStatus,
      this.reviewsQnt,
      this.reviews});

  factory ResponseGetLocationsById.fromJson(Map<String, dynamic> json) {
    return ResponseGetLocationsById(
      id: json['id'],
      name: json['name'],
      endereco: json['endereco'],
      type: json['type'],
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
