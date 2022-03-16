import 'dart:core';
import 'package:is_it_safe_app/core/data/service/config/api_service.dart';
import 'package:is_it_safe_app/core/model/Location.dart';

class SearchService {
  final APIService _service = APIService();

  Future getLocation() async {
    final _response = await _service.doRequest(
      RequestConfig(
        'location/find-all',
        HttpMethod.get,
      ),
    );

    List<Location> _locations =
        (_response as List).map((e) => Location.fromJson(e)).toList();
    return _locations;
  }
}
