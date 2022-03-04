import 'package:is_it_safe_app/core/model/location/location.dart';

import 'config/api_service.dart';

class HomeService {
  final APIService _service = APIService();

  ///Receber os lugares próximos e suas avaliações
  Future getLocations() async {
    final _response = await _service.doRequest(
      RequestConfig(
        'location/find-all',
        HttpMethod.get,
      ),
    );
    final _locations = Location.fromJson(_response as Map<String, dynamic>);
    return _locations;
  }
}
