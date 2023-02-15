import 'package:is_it_safe_app/src/service/api/modules/location/response/response_location_review.dart';

class ResponseSaveLocation {
  int? id;
  String? name;
  String? endereco;
  double? averageGrade;
  int? reviewsQnt;
  String? imgUrl;
  String? averageImpressionStatus;
  final List<ResponseLocationReview>? reviews;

  ResponseSaveLocation(
      {this.id,
      this.name,
      this.endereco,
      this.averageGrade,
      this.reviewsQnt,
      this.imgUrl,
      this.averageImpressionStatus,
      this.reviews});

  factory ResponseSaveLocation.fromJson(Map<String, dynamic> json) {
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
