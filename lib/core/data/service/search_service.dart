import 'dart:core';
import 'package:is_it_safe_app/core/data/service/config/api_service.dart';
import 'package:is_it_safe_app/core/model/Location.dart';

class SearchService {
  final APIService _service = APIService();

  Future getLocation(search) async {
    final _response = await _service.doRequest(
      RequestConfig(
        'location/find-all?name=$search',
        HttpMethod.get,
      ),
    );

    List<Content> _locations =
        (_response["content"] as List).map((e) => Content.fromJson(e)).toList();
    return _locations;
  }
}
