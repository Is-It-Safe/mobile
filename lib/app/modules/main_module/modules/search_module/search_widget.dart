import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/components/list_tile.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends ModularState<SearchWidget, SearchBloc> {
  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
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
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: MediaQuery.of(context).size.height - 215,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return searchListTile(
                          context: context,
                          
                          name: 'name $index',
                          endereco: 'endereco $index',
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
