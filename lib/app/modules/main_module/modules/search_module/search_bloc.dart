import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';
import 'package:is_it_safe_app/core/model/Search.dart';

class SearchBloc implements Disposable {

  @override
  void dispose() {}
}

class SearchController{
    List<SearchModel> searchs = [];
    final repository = Search();

    Future start() async{
      searchs = await repository.featchPlace();
    }
}
