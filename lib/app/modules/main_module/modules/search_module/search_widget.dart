import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/components/search_list_tile.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/data/service/search_service.dart';
import 'package:is_it_safe_app/core/model/Search.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends ModularState<SearchWidget, SearchBloc> {
  late Future<List<SearchModel>> futurePlace;

  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
    futurePlace = Search().featchPlace();
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
                  child: StreamBuilder<SearchModel>(
                    stream: null,
                    builder: (context, snapshot) {
                      

                      return FutureBuilder<List<SearchModel>>(
                        future: futurePlace,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return searchListTile(
                            context: context,
                            name: 'results.name[$index]',
                            endereco: 'results.endereco [$index]',
                            imgUrl: 'results.imgUrl [$index]',
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                           return Text('${snapshot.error}');} 
                          else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      );




                    }
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
