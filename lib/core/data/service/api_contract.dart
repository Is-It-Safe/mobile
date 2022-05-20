import 'package:dio/dio.dart';
import 'package:is_it_safe_app/core/data/service/api.dart';

abstract class ApiContract {
  Future doRequest(RequestConfig config);
  returnResponse(Response response);
}