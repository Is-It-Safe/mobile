import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/api_service.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';
import 'package:is_it_safe_app/src/service/api/configuration/request_config.dart';
import 'package:is_it_safe_app/src/service/api/constants/api_constants.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/home_service_interface.dart';
import 'package:is_it_safe_app/src/service/api/modules/home/response/response_get_best_rated_locations.dart';

class HomeService implements IHomeService {
  final ApiService _service = ApiService();
  @override
  Future<List<ResponseGetBestRatedLocationsLocation>?>
      getBestRatedLocations() async {
    final requestConfig = RequestConfig(
      path: ApiConstants.getBestRatedLocations,
      method: HttpMethod.get,
      options: Options(
        headers: {
          ApiConstants.kAuthorization: ApiConstants.kBarearAuth(),
        },
      ),
    );

    final response = await _service.doRequest(requestConfig);

    return ResponseGetBestRatedLocations.fromJson(response).locations;
  }
}
