import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/profile/error/safe_profile_error.dart';
import 'package:is_it_safe_app/src/app/modules/profile/services/profile_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:result_dart/result_dart.dart';

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
