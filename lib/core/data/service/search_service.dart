import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/mockup_results/results_mockup.dart';
import 'package:is_it_safe_app/core/model/Search.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

class Search {
  final dio = DioMock();
  final url = '';

  

  Future<List<SearchModel>> featchPlace() async {

    when(dio.get(url)).thenAnswer((realInvocation) async => Response(
        data: jsonDecode(searchResultsData),
        requestOptions: RequestOptions(method: 'GET', path: 'url')));

    final response = await dio.get(url);
    final list = response.data as List;
    return list.map((json) => SearchModel.fromJson(json)).toList();
  }
}


