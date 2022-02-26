import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';
import 'package:is_it_safe_app/core/model/Search.dart';

class SearchBloc implements Disposable {
  final searchService = SearchService();

  List<SearchModel> places = [];
  

  Future <List<SearchModel>> getAllPlaces() async {
    
    places = await searchService.getPlace();
    return places;
    
  }

  @override
  void dispose() {}
}
