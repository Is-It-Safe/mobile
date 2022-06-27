import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/core/constants/int_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';
import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/domain/entity/sexual_orientation_entity.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/auth_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/auth/response/response_sexual_orientation.dart';

class GetSexualOrientationsUseCase extends SafeUseCase {
  late final IAuthService _service;

  GetSexualOrientationsUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<List<SexualOrientationEntity>> call() async {
    final _response = await _service.getSexualOrientations();

    return _parseResponseToEntity(_response);
  }

//TODO implementar SexualOrientation.toEntity
  List<SexualOrientationEntity> _parseResponseToEntity(
      List<ResponseSexualOrientation> response) {
    final _listSexualOrientations = <SexualOrientationEntity>[];

    for (final item in response) {
      final sexualOrientation = SexualOrientationEntity(
        id: item.id ?? IntConstants.empty,
        title: item.title ?? StringConstants.empty,
      );
      _listSexualOrientations.add(sexualOrientation);
    }
    return _listSexualOrientations;
  }
}
