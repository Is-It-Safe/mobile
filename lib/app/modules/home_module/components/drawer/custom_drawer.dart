import 'package:flutter/material.dart';
import 'package:is_it_safe_app/app/modules/home_module/components/drawer/custom_header.dart';
import 'package:is_it_safe_app/app/modules/home_module/components/drawer/custom_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                CustomHeaderDrawer(),
                CustomTileDrawer(iconPath: 'adicionar_local.svg', title: 'Adicionar Local'),
                CustomTileDrawer(iconPath: 'minha_conta.svg', title: 'Minha Conta'),
                CustomTileDrawer(iconPath: 'configuracoes.svg', title: 'Configurações'),
                CustomTileDrawer(iconPath: 'privacidade.svg', title: 'Privacidade'),
                CustomTileDrawer(iconPath: 'termos_uso.svg', title: 'Termos De Uso'),
                CustomTileDrawer(iconPath: 'sobre.svg', title: 'Sobre'),
                CustomTileDrawer(iconPath: 'contato.svg', title: 'Contato'),
              ],
            )
          ],
        ),
      ),
    );
  }
}