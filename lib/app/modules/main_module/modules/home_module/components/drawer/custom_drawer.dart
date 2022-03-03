import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'custom_header.dart';
import 'custom_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                const CustomHeaderDrawer(),
                //TODO: Ajustar as rotas para os locais corretos após criacoes das paginas
                CustomTileDrawer(
                  iconPath: 'adicionar_local.svg',
                  title: 'Adicionar Local',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'minha_conta.svg',
                  title: 'Minha Conta',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'configuracoes.svg',
                  title: 'Configurações',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'privacidade.svg',
                  title: 'Privacidade',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'termos_uso.svg',
                  title: 'Termos De Uso',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'sobre.svg',
                  title: 'Sobre',
                  route: kRouteProfile,
                ),
                CustomTileDrawer(
                  iconPath: 'contato.svg',
                  title: 'Contato',
                  route: kRouteProfile,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
