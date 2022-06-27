import 'package:is_it_safe_app/src/core/constants/double_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/response/response_get_user.dart';

class ReviewEntity {
  int id;
  String? review;
  String? impressionStatus;
  double? myGrade;

  ReviewEntity({
    required this.id,
    this.review,
    this.impressionStatus,
    this.myGrade,
  });

  factory ReviewEntity.toEntity(ResponseGetUserReview review) {
    return ReviewEntity(
      id: review.id!,
      review: review.review ?? StringConstants.empty,
      impressionStatus: review.impressionStatus ?? StringConstants.empty,
      myGrade: review.myGrade ?? DoubleConstants.empty,
    );
  }
}
