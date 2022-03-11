import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/utils/style/themes/text_styles.dart';

//Tile do Drawer personalizado
class CustomTileDrawer extends StatelessWidget {
  final String iconPath;
  final String title;
  final String route;

  const CustomTileDrawer({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.navigate(route),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: SvgPicture.asset('images/app/home/drawer/$iconPath'),
          ),
          Text(
            title,
            style: TextStyles.subtitle1(),
          ),
        ],
      ),
    );
  }
}
