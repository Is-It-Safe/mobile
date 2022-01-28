import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/search_module/search_bloc.dart';

import 'dart:developer' as dev;

import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class SearchWidget extends StatefulWidget {
  final String title;
  const SearchWidget({Key? key, this.title = 'SearchPagePage'})
      : super(key: key);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends ModularState<SearchWidget, SearchBloc> {
  @override
  void initState() {
    super.initState();
    dev.log(Modular.to.path, name: "PATH");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.symmetric(
              vertical: 63,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: MyTextFormField(
                                      readOnly: false,
                                      labelText: "Search",
                                      prefixIcon: Icon(Icons.search),
                                    ),
                    
                    /*TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color(0xFF190A33),
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                      
                    ),
                    style: TextStyle(
                      color: Color(0xFF190A33),
                    ),
                  ),*/
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
