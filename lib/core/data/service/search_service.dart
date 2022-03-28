import 'dart:convert';
import 'dart:core';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/mockup_results/search_results_mockup.dart';
import 'package:is_it_safe_app/core/model/Search.dart';


class SearchService {
  
  Future getPlace() async {
    final response = jsonDecode(searchResultsMockup);       
    final list = response as List;
    
    final places = list
        .map((e) => SearchModel(
              id: e['id'],
              name: e['name'],
              endereco: e['endereco'],
              imgUrl: e['imgUrl'],
            ))
        .toList();
    
    return places;
  }
}
