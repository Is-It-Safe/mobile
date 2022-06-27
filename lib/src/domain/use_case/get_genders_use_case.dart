import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/gender_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_gender.dart';

class GetGendersUseCase extends SafeUseCase {
  late final IAuthService _service;

  GetGendersUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<List<GenderEntity>> call() async {
    final _response = await _service.getGenders();

    return _parseResponseToEntity(_response);
  }

//TODO implementar GenderEntity.toEntity
  List<GenderEntity> _parseResponseToEntity(List<ResponseGender> response) {
    final _listGenders = <GenderEntity>[];

    for (final item in response) {
      final gender = GenderEntity(
        id: item.id ?? IntConstants.empty,
        title: item.title ?? StringConstants.empty,
      );
      _listGenders.add(gender);
    }
    return _listGenders;
  }
}
