import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';
import 'package:is_it_safe_app/core/model/Search.dart';

class SearchBloc implements Disposable {
  final searchService = SearchService();

  ///StreamControllers
  late StreamController<BaseResponse<List<SearchModel>>> searchController;

  ///TextEditingControllers
  late TextEditingController nameSearchController;

  List<SearchModel> places = [];

  SearchBloc(){
    searchController = StreamController.broadcast();

    nameSearchController = TextEditingController();

  }
  

  Future  getAllPlaces() async {
    try {
    searchController.sink.add(BaseResponse.loading());
    final places = await searchService.getPlace();
    searchController.sink.add(BaseResponse.completed(data: places));
    } catch (e) {
    searchController.sink.add(BaseResponse.error(e.toString()));
    }
   
    
  }

  @override
  void dispose() {
    searchController.close();
  }
}
