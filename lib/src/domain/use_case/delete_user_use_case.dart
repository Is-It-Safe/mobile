import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/service/api/modules/profile/profile_service_interface.dart';
import 'package:result_dart/result_dart.dart';

import '../../../generated/l10n.dart';

class DeleteUserUseCase extends SafeUseCase {
  final IProfileService service;

  DeleteUserUseCase(this.service);

  Future<Result<String, SafeProfileError>> call({
    required int idUser,
  }) async {
    try {
      final response = await service.deleteUser(idUser: idUser);
      return Success(response.message ?? S.current.textDeleteUser);
    } on SafeProfileError catch (e) {
      throw Failure(e);
    }
  }
}
