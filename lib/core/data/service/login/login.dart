import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/core/data/service/api.dart';
import 'package:is_it_safe_app/core/data/service/config/api_constants.dart';
import 'package:is_it_safe_app/core/data/service/login/login_contract.dart';

class LoginService implements LoginContract {
  final APIService _service = APIService();

  @override
  Future<Map<String, dynamic>> doLogin({
    required String username,
    required String password,
  }) async {
    //TODO Auth Mock
    // username = 'cvpinhofsa@gmail.com';
    // password = '123456';
    String basicAuth = 'Basic ' +
        base64Encode(
          utf8.encode('isitsafe:isitsafe123'),
        );
    var formData = FormData.fromMap(
      {'username': username, 'password': password, 'grant_type': 'password'},
    );

    final _response = await _service.doRequest(
      RequestConfig(
        ApiConstants.kAuthUtl,
        HttpMethod.post,
        body: formData,
        options: Options(
          headers: {
            'Authorization': basicAuth,
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      ),
    );
    return _response;
  }
}
