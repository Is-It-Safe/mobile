import 'package:is_it_safe_app/core/model/location/location.dart';

import 'config/api_service.dart';

class HomeService {
  final APIService _service = APIService();

  ///Receber os lugares melhores avaliados
  Future getBestRatedLocations() async {
    final _response = await _service.doRequest(
      RequestConfig(
        'location/find-all',
        HttpMethod.get,
      ),
    );
    final _locations = Locations.fromJson(_response as Map<String, dynamic>);
    return _locations;
  }

  ///Receber os lugares próximos e suas avaliações
  Future getClosePlacesLocations() async {
    return Locations(content: []);
  }
}
