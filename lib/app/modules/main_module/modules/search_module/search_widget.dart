import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/components/search_list_tile.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/search_module/search_bloc.dart';
import 'package:is_it_safe_app/core/components/my_text_form_field.dart';
import 'package:is_it_safe_app/core/data/service/config/base_response.dart';
import 'package:is_it_safe_app/core/model/Location.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/helper/manage_dialogs.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

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

  _onError(AsyncSnapshot snapshot) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ManagerDialogs.showErrorDialog(
        context,
        snapshot.data.message,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 63),
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
                      controller
                          .getAllLocation(controller.nameSearchController.text);
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder<BaseResponse<List<Content>>>(
                    stream: controller.searchController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data?.status) {
                          case Status.LOADING:
                            return Center(
                              child: Text(
                                S.of(context).textLoading,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            );
                          case Status.ERROR:
                            _onError(snapshot);
                            return Center(
                              child: Text(
                                S.of(context).textErrorSearch,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            );
                          default:
                            return ListView.builder(
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                return SearchResults(
                                  name: snapshot.data!.data![index].name,
                                  endereco:
                                      snapshot.data!.data![index].endereco,
                                  imgUrl: snapshot.data?.data?[index].imgUrl,
                                );
                              },
                            );
                        }
                      }
                      return Container();
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
