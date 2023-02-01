import 'package:is_it_safe_app/src/app/modules/auth/error/safe_auth_error.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:result_dart/result_dart.dart';

class GetSexualOrientationsUseCase extends SafeUseCase {
  late final IAuthService service;

  GetSexualOrientationsUseCase(this.service);

  Future<Result<List<SexualOrientationEntity>, SafeAuthError>> call() async {
    try {
      final response = await service.getSexualOrientations();

      return Success(
          response.map((e) => SexualOrientationEntity.toEntity(e)).toList());
    } on SafeAuthError catch (e) {
      return Failure(e);
    }
  }
}
