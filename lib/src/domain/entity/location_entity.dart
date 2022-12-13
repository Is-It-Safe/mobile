import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';

class LocationEntity {
  final int id;
  final String name;
  final String address;
  String? imagePath;
  double? averageGrade;
  String? averageImpressionStatus;
  int? reviewsQnt;
  ReviewEntity? reviewEntity;

  LocationEntity({
    required this.id,
    required this.name,
    required this.address,
    this.imagePath,
    this.averageGrade,
    this.averageImpressionStatus,
    this.reviewsQnt,
    this.reviewEntity,
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
      reviewEntity: ReviewEntity(
        id: location.review.id ?? 0,
        review: location.review ?? StringConstants.empty,
        author: location.author ?? StringConstants.empty,
        createdAt: location.createdAt ?? StringConstants.empty,
      ),
    );
  }
}
