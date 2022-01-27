import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/search_module/search_bloc.dart';

class SearchWidget extends StatefulWidget {
  final String title;
  const SearchWidget({Key? key, this.title = 'SearchPagePage'}) : super(key: key);
  @override
 SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends ModularState<SearchWidget, SearchBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
