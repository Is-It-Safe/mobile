import 'package:is_it_safe_app/src/service/api/modules/add_location/response/request_add_location.dart';

abstract class AddLocationServiceContract {
  Future<bool> addLocationService({
    required RequestAddLocation request,
  });
}
