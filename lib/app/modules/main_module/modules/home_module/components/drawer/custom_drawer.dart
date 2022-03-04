import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import 'custom_header.dart';
import 'custom_tile.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final String? profileImagePath;
  const CustomDrawer({Key? key, required this.name, this.profileImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeaderDrawer(
                name: name,
                profileImagePath: profileImagePath,
              ),
              //TODO: Ajustar as rotas para os locais corretos após criacoes das paginas
              const CustomTileDrawer(
                iconPath: 'adicionar_local.svg',
                //TODO Colocar texto no INTL
                title: 'Adicionar Local',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'minha_conta.svg',
                //TODO Colocar texto no INTL
                title: 'Minha Conta',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'configuracoes.svg',
                //TODO Colocar texto no INTL
                title: 'Configurações',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'privacidade.svg',
                //TODO Colocar texto no INTL
                title: 'Privacidade',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'termos_uso.svg',
                //TODO Colocar texto no INTL
                title: 'Termos De Uso',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'sobre.svg',
                //TODO Colocar texto no INTL
                title: 'Sobre',
                route: kRouteProfile,
              ),
              const CustomTileDrawer(
                iconPath: 'contato.svg',
                //TODO Colocar texto no INTL
                title: 'Contato',
                route: kRouteProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
