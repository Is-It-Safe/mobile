import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

//Tile do Drawer personalizado
class CustomTileDrawer extends StatelessWidget {

  CustomTileDrawer({required this.iconPath,required  this.title});
  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        //TODO: Criar navegação
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