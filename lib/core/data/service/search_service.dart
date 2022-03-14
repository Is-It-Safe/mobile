import 'dart:convert';
import 'dart:core';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/mock/search_results_mockup.dart';
import 'package:is_it_safe_app/core/model/Search.dart';

class SearchService {
  Future getPlace() async {
    //TODO Fazer conexão com a API
    final response = jsonDecode(searchResultsMockup);
    //TODO Nomear variável de forma mais clara. EX: listPlaces
    final list = response as List;

    final places = list
        //TODO Utilizar Métodos toJson para transformar de Json para um objeto Dart
        //TODO Há exemplos de como fazer isso na classe register_service
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
