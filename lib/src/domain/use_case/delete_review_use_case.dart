import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/location/location_service_interface.dart';

class DeleteReviewUseCase extends SafeUseCase {
  late final ILocationService _service;

  DeleteReviewUseCase() {
    _service = Modular.get<LocationService>();
  }

  Future<String> call(int idReview) async {
    final response = await _service.deleteReview(idReview);

    return response.message ?? S.current.textDefaultDeleteReviewMessage;
  }
}
