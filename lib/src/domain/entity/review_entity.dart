import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/location_entity.dart';

class ReviewEntity {
  final int id;
  final String? review;
  final double? myGrade;
  final LocationEntity? location;
  final String? author;
  final String? createdAt;
  final String? impressionStatus;

  ReviewEntity({
    required this.id,
    this.review,
    this.myGrade,
    this.location,
    this.author,
    this.createdAt,
    this.impressionStatus,
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

  factory ReviewEntity.fromProfileReview(dynamic review) {
    return ReviewEntity(
      id: review.id ?? 0,
      review: review.review ?? StringConstants.empty,
      myGrade: review.myGrade ?? DoubleConstants.empty,
      author: review.author ?? StringConstants.empty,
      createdAt: review.createdAt ?? StringConstants.empty,
      location: LocationEntity(
        id: review.locationId ?? 0,
        name: review.locationName ?? StringConstants.hyphen,
        address: review.locationAddress ?? StringConstants.hyphen,
      ),
      impressionStatus: review.impressionStatus ?? StringConstants.empty,
    );
  }
}
