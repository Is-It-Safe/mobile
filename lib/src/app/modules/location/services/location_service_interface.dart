import 'package:is_it_safe_app/src/app/modules/location/domain/entities/request/request_save_location.dart';
import 'package:is_it_safe_app/src/app/modules/location/domain/entities/response/response_get_location_by_id.dart';
import '../domain/entities/response/response_save_location.dart';

abstract class ILocationService {
  Future<ResponseGetLocationsById> getLocationById(int id);
  Future<ResponseSaveLocation> saveLocation(RequestSaveLocation request);
  Future<void> getLocationByCep(int cep);
}
