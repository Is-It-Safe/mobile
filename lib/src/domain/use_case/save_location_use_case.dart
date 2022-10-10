import 'package:is_it_safe_app/src/core/interfaces/safe_use_case.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/add_location_service.dart';
import 'package:is_it_safe_app/src/service/api/modules/add_location/response/request_add_location.dart';

class SaveLocationUseCase extends SafeUseCase {
  Future<bool> call({required RequestAddLocation request}) async {
    try {
      return AddLocationService().addLocationService(request: request);
    } catch(e) {
      LogUtil().error(e.toString());
    }
    return false;
  }
}