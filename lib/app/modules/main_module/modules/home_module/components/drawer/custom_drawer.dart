import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';

import '../../../../../../../generated/l10n.dart';
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
              CustomTileDrawer(
                iconPath: 'adicionar_local.svg',
                title: S.of(context).textDrawerAddLocation,
                route: kRouteProfile,
              ),
              CustomTileDrawer(
                iconPath: 'minha_conta.svg',
                title: S.of(context).textDrawerMyAccount,
                route: kRouteMyAccount,
              ),
              CustomTileDrawer(
                iconPath: 'configuracoes.svg',
                title: S.of(context).textDrawerConfiguration,
                route: kRouteProfile,
              ),
              CustomTileDrawer(
                iconPath: 'privacidade.svg',
                title: S.of(context).textDrawerPrivacy,
                route: kRouteTermsOfUse,
              ),
              CustomTileDrawer(
                iconPath: 'termos_uso.svg',
                title: S.of(context).textDrawerTerms,
                route: kRouteTermsOfUse,
              ),
              CustomTileDrawer(
                iconPath: 'sobre.svg',
                title: S.of(context).textDrawerAbout,
                route: kRouteProfile,
              ),
              CustomTileDrawer(
                iconPath: 'contato.svg',
                title: S.of(context).textDrawerContact,
                route: kRouteProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
