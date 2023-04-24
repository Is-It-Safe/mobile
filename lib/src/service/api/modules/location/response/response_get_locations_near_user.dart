import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_location_by_id.dart';

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
  final List<ReviewChart>? reviewChart;

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
    this.reviewChart,
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
      reviewChart: json['chart'] != null
          ? (json['chart'] as Map)
              .entries
              .map((e) => ReviewChart(key: e.key, value: e.value))
              .toList()
          : null,
    );
  }
}
