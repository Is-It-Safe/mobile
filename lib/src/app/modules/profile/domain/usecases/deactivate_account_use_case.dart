import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:result_dart/result_dart.dart';

class DeactivateAccountUseCase extends SafeUseCase {
  final IProfileService service;

  DeactivateAccountUseCase(this.service);

  Future<Result<String, SafeProfileError>> call() async {
    try {
      final response = await service.deactivateAccount();
      return Success(response);
    } on SafeProfileError catch (e) {
      return Failure(e);
    }
  }
}
