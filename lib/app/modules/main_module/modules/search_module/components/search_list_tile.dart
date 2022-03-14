import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

//TODO Todos os componentes são estruturados com um Stateless ou Stateful Widget
ListTile searchListTile({
  int? id,
  required BuildContext context,
  required String name,
  required String endereco,
  String? imgUrl,
}) {
  return ListTile(
    title: Row(
      children: [
        Stack(
          children: [
            Container(
              //TODO Largura fixa não é sempre responsivo, usar o Media Query
              width: 102,
              //TODO Altura fixa não é sempre responsivo, usar o Media Query
              height: 90,
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: Image.asset(
                          ('images/app/search_pictures/placeholder/placeholder_image.png'))
                      .image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              //TODO Largura fixa não é sempre responsivo, usar o Media Query
              width: 102,
              //TODO Altura fixa não é sempre responsivo, usar o Media Query
              height: 90,
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: (imgUrl == null)
                      ? Image.asset(
                              ('images/app/search_pictures/placeholder/no_image.jpg'))
                          .image
                      : NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            //TODO Altura fixa não é sempre responsivo, usar o Media Query
            height: 90,
            //TODO Utilizar multiplicação ao invés de + ou - quando usar o MediaQuery
            //TODO Exemplo: MediaQuery.of(context).size.height * 0.3 (0.3 representa a porcentagem da tela que o MediaQuery vai utilizar)
            width: MediaQuery.of(context).size.width - 185,
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  //TODO Utilizar multiplicação ao invés de + ou - quando usar o MediaQuery
                  //TODO Exemplo: MediaQuery.of(context).size.height * 0.3 (0.3 representa a porcentagem da tela que o MediaQuery vai utilizar)
                  width: MediaQuery.of(context).size.width - 185,
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyles.bodyText1(),
                  ),
                ),
                SizedBox(
                  //TODO Utilizar multiplicação ao invés de + ou - quando usar o MediaQuery
                  //TODO Exemplo: MediaQuery.of(context).size.height * 0.3 (0.3 representa a porcentagem da tela que o MediaQuery vai utilizar)
                  width: MediaQuery.of(context).size.width - 185,
                  child: Text(
                    endereco,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyles.label(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
