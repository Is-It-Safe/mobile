import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/response/response_get_best_rated_places.dart';

class LocationEntity {
  final int id;
  final String name;
  final String address;
  String? imagePath;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;
  ReviewEntity? reviewEntity;
  String? cep;
  int? locationTypeId;
  String? imgUrl;

  LocationEntity({
    required this.id,
    required this.name,
    required this.address,
    this.imagePath,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.reviewEntity,
    this.cep,
    this.locationTypeId,
    this.imgUrl,
  });

  factory LocationEntity.toEntity(dynamic location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.endereco ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
          location.averageImpressionStatus ?? StringConstants.empty,
    );
  }

  factory LocationEntity.toEntityGetRatedPlaces(
      ResponseGetRatedPlaces location) {
    return LocationEntity(
      id: location.id ?? IntConstants.empty,
      name: location.name ?? StringConstants.empty,
      address: location.endereco ?? StringConstants.empty,
      averageGrade: location.averageGrade ?? DoubleConstants.empty,
      reviewsQnt: location.reviewsQnt ?? IntConstants.empty,
      imagePath: location.imgUrl ?? StringConstants.empty,
      averageImpressionStatus:
          location.averageImpressionStatus ?? StringConstants.empty,
      reviewEntity: ReviewEntity(
        id: location.reviewId ?? 0,
        review: location.reviewReview ?? StringConstants.empty,
        author: location.reviewAuthor ?? StringConstants.empty,
        createdAt: location.reviewCreatedAt ?? StringConstants.empty,
      ),
    );
  }
}
