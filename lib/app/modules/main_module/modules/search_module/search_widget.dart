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
  //TODO Não seria melhor mudar essa lista para o BloC?
  //TODO Não vi essa lista sendo utilizada, remover caso não esteja utilizando
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
                      controller.getAllPlaces();
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //TODO Utilizar multiplicação ao invés de + ou - quando usar o MediaQuery
                  //TODO Exemplo: MediaQuery.of(context).size.height * 0.3 (0.3 representa a porcentagem da tela que o MediaQuery vai utilizar)
                  height: MediaQuery.of(context).size.height - 215,
                  child: StreamBuilder<BaseResponse<List<SearchModel>>>(
                    stream: controller.searchController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //TODO Não está utilizando os status do BaseResponse para melhor definir o que será exibido na tela
                        //TODO Verificar exemplos em outras telas ou solicitar ajuda para montar esse pedaço
                        return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return searchListTile(
                              context: context,
                              name: snapshot.data!.data![index].name,
                              endereco: snapshot.data!.data![index].endereco,
                              imgUrl: snapshot.data?.data?[index].imgUrl,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        //TODO Quando há erro, nós não exibimos um Text, temos uma classe de Dialogs que são exibidos de acordo com o Status do Base Response
                        //TODO Não utilizamos o snapshot.hasError, pois o Base Response já se encarrega de fazer esse gerenciamento de erros
                        return Text('${snapshot.error}');
                      } else {
                        //TODO No caso, esse 'else' é caso a busca não retorne elementos, deve ser retornado a illustração/widget de empty state
                        return Center(
                          child: Container(),
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
