import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            
                            Stack(
                              children: [
                                Container(
                                  width: 102,
                                  height: 90,
                                  margin: const EdgeInsets.only(top:30),
                                  child: const Center(
                                    child: CircularProgressIndicator(color: Color(0xFF5C45ED),
                                    strokeWidth: 2,),
                                  ),
                                ),
                                Container(
                                  width: 102,
                                  height: 90,
                                  margin: const EdgeInsets.only(top:30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://i.imgur.com/Nx4nMYz.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                  height: 90,
                                  width:
                                      MediaQuery.of(context).size.width - 185,
                                  color: Colors.amber,
                                  margin: const EdgeInsets.only(top:30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        child: Text(
                                          'Esse titulo é o $index',
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          style: TextStyles.bodyText1(),                                        
                                        ),
                                      ),
                                      SizedBox(


                                         width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        child: Text(
                                          'rua estabelecimento $index, bairro $index, cidade $index, UF, Brasil',
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          style: TextStyles.label(), 
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
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
