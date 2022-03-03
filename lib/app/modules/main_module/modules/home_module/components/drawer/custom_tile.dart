import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/utils/constants/routes.dart';

//Tile do Drawer personalizado
class CustomTileDrawer extends StatelessWidget {

  CustomTileDrawer({required this.iconPath,required  this.title,required this.route});
  final String iconPath;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Modular.to.navigate(route);
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 32),
            child: SvgPicture.asset('images/app/home/drawer/$iconPath')
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 18,fontWeight: FontWeight.w400)
          ),
        ],
      ),
    );
  }
}