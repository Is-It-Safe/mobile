import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/review_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/request/request_save_review.dart';

class SaveReviewUseCase extends SafeUseCase {
  late final ILocationService _service;

  SaveReviewUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<ReviewEntity> call({
    required String review,
    required int grade,
    required String impressionStatus,
    required int locationId,
  }) async {
    final request = RequestSaveReview(
      review: review,
      grade: grade,
      impressionStatus: impressionStatus,
      locationId: locationId,
    );
    final response = await _service.doReview(request);
    return ReviewEntity.toEntity(response);
  }
}
