import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/data/service/search/search_contract.dart';
import 'package:is_it_safe_app/core/data/service/search/search_service.dart';
import 'package:is_it_safe_app/core/model/Location.dart';

class SearchBloc implements Disposable {
  final SearchContract searchService;

  late StreamController<BaseResponse<List<Content>>> searchController;

  late TextEditingController nameSearchController;

  List<Content> places = [];

  SearchBloc({required this.searchService}) {
    searchController = StreamController.broadcast();
    nameSearchController = TextEditingController();
  }

  Future getAllLocation(search) async {
    try {
      searchController.sink.add(BaseResponse.loading());
      final places = await searchService.getLocation(search);
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
