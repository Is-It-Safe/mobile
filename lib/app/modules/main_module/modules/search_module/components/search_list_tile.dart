import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

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
              width: 102,
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
              width: 102,
              height: 90,
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    imgUrl ?? '',
                  ),
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
            width: MediaQuery.of(context).size.width - 185,
            margin: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 185,
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyles.bodyText1(),
                  ),
                ),
                SizedBox(
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
