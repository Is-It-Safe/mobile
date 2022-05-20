import 'package:is_it_safe_app/core/data/service/home/home_contract.dart';
import 'package:is_it_safe_app/core/model/location/location.dart';

import '../api.dart';

class HomeService implements HomeContract {
  final APIService _service = APIService();

  ///Receber os lugares melhores avaliados
  @override
  Future<Locations> getBestRatedLocations() async {
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
  @override
  Future<Locations> getClosePlacesLocations() async {
    return Locations(content: []);
  }
}
