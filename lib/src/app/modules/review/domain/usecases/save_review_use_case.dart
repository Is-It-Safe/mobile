import 'package:is_it_safe_app/src/app/modules/review/error/safe_review_error.dart';
import 'package:is_it_safe_app/src/app/modules/review/domain/models/request/request_save_review.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:result_dart/result_dart.dart';

class SaveReviewUseCase extends SafeUseCase {
  late final IProfileService service;

  SaveReviewUseCase(this.service);

  Future<Result<ReviewEntity, SafeReviewError>> call({
    required String review,
    required int grade,
    required String impressionStatus,
    required int locationId,
  }) async {
    try {
      final request = RequestSaveReview(
        review: review,
        grade: grade,
        impressionStatus: impressionStatus,
        locationId: locationId,
      );
      final response = await service.saveReview(request);
      return Success(ReviewEntity.toEntity(response));
    } on SafeReviewError catch (e) {
      return Failure(e);
    }
  }
}
