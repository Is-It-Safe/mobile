import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class SearchResults extends StatelessWidget {
  final int? id;
  final String? name;
  final String? endereco;
  final String? imgUrl;

  const SearchResults({
    Key? key,
    this.id,
    this.name,
    this.endereco,
    this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeReference = MediaQuery.of(context).size.width;
    return ListTile(
      title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: sizeReference * 0.25,
            height: sizeReference * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Image.network(
              imgUrl!,
              fit: BoxFit.fill,
              errorBuilder: (context, object, stackTrace) {
                return Image.asset(
                  'images/app/search_pictures/placeholder/search_placeholder.png',
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: sizeReference * 0.22,
              width: sizeReference * 0.50,
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: sizeReference * 0.500,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name ?? '',
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyles.bodyText1(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sizeReference * 0.75,
                    child: Text(
                      endereco ?? '',
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
}
