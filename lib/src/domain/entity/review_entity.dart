import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/domain/entity/location_entity.dart';

class ReviewEntity {
  final int id;
  final String? review;
  final double? myGrade;
  final LocationEntity? location;
  final String? author;
  final String? createdAt;

  ReviewEntity({
    required this.id,
    this.review,
    this.myGrade,
    this.location,
    this.author,
    this.createdAt,
  });

  factory ReviewEntity.toEntity(dynamic review) {
    return ReviewEntity(
      id: review.id ?? 0,
      review: review.review ?? StringConstants.empty,
      myGrade: review.myGrade ?? DoubleConstants.empty,
      author: review.author ?? StringConstants.empty,
      createdAt: review.createdAt ?? StringConstants.empty,
    );
  }
}
