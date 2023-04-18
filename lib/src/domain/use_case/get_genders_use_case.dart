import 'package:is_it_safe_app/src/app/modules/auth/services/auth_service_interface.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:result_dart/result_dart.dart';

import '../../app/modules/auth/error/safe_auth_error.dart';

class GetGendersUseCase extends SafeUseCase {
  final IAuthService service;

  GetGendersUseCase(this.service);

  Future<Result<List<GenderEntity>, SafeAuthError>> call() async {
    try {
      final response = await service.getGenders();

      return Success(response.map((e) => GenderEntity.toEntity(e)).toList());
    } on SafeAuthError catch (e) {
      return Failure(e);
    }
  }
}
