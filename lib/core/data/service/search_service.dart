import 'dart:convert';
import 'dart:core';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/mock/search_results_mockup.dart';
import 'package:is_it_safe_app/core/data/service/config/api_service.dart';
import 'package:is_it_safe_app/core/model/Location.dart';

class SearchService {
  final APIService _service = APIService();
  //TODO Fazer conexão com a API

  Future getLocation() async {
    //TODO Trocar o mock 
    final location = jsonDecode(searchResultsMockup);
    final listLocation = location as List;

    final locations =
        listLocation.map((location) => Location.fromJson(location)).toList();

    return locations;
  }
}
