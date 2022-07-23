import 'dart:convert';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:is_it_safe_app/src/service/api/configuration/http_method.dart';

import '../../configuration/api_service.dart';
import '../../configuration/request_config.dart';
import '../../constants/api_constants.dart';
import 'response/response_get_location_by_id.dart';

class ReviewService {
  final ApiService _service = ApiService();

  Future<List<ResponseGetLocationsById>> getLocationById({required int locationId}) async {
    final requestConfig = RequestConfig(
      path: '${ApiConstants.getLocationById}/$locationId',
      method: HttpMethod.get,
    );

    final response = await _service.doRequest(requestConfig);
    return (json.decode(response.data) as List)
        .map((e) => ResponseGetLocationsById.fromJson(e))
        .toList();
  }





  Future postReview(id, review, grade, impressionStatus) async {
    var auth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstants.kClientId}:${ApiConstants.kClientSecret}'));
    final _response = await _service.doRequest(
      RequestConfig(
        'review/save',
        HttpMethod.post,
        body: jsonEncode(<String, dynamic>{
          "review": "$review",
          "grade": grade,
          "impressionStatus": "$impressionStatus",
          "location_id": id
        }),
        options: Options(
          headers: <String, String>{'authorization': auth},
        ),
      ),
    );
    return _response;
  }
}
