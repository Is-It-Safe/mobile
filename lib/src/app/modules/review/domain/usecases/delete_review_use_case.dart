import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:result_dart/result_dart.dart';

class DeleteReviewUseCase extends SafeUseCase {
  final IProfileService _service;

  DeleteReviewUseCase(this._service);

  Future<Result<String, SafeProfileError>> call(int? idReview) async {
    try {
      if (idReview != null) {
        final response = await _service.deleteReview(idReview);
        return Success(
            response.message ?? S.current.textDefaultDeleteReviewMessage);
      } else {
        return Success(S.current.textErrorDeleteReview);
      }
    } on SafeProfileError catch (e) {
      return Failure(e);
    }
  }
}
