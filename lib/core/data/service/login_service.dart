import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/core/data/service/config/api_constants.dart';
import 'package:is_it_safe_app/core/data/service/config/api_service.dart';

class LoginService {
  final APIService _service = APIService();
  Future doLogin({required String username, required String password}) async {
    var auth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstants.kClientId}:${ApiConstants.kClientSecret}'));
    final _response = await _service.doRequest(
      RequestConfig(
        'oauth/token',
        HttpMethod.post,
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
          'grant_type': 'password'
        }),
        options: Options(
          headers: <String, String>{'authorization': auth},
        ),
      ),
    );
    return _response;
  }
}
