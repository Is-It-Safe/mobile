import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/components/search_list_tile.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/Search.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends ModularState<SearchWidget, SearchBloc> {
  late Future<List<SearchModel>> futurePlaces;

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
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: MyTextFormField(
                    controller: controller.nameSearchController,
                    readOnly: false,
                    labelText: S.of(context).textSearchForm,
                    prefixIcon: const Icon(Icons.search),
                    onEditingComplete: () {
                      controller.getAllPlaces();
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: MediaQuery.of(context).size.height - 215,
                  child:  StreamBuilder<BaseResponse<List<SearchModel>>>(
                    stream: controller.searchController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return searchListTile(
                              context: context,
                              name: snapshot.data!.data![index].name,
                              endereco: snapshot.data!.data![index].endereco,
                              imgUrl:snapshot.data?.data?[index].imgUrl,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return Center(
                          child:  Container(),
                        );
                      }
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
