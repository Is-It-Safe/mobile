import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

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
              CustomTileDrawer(
                iconPath: 'adicionar_local.svg',
                title: S.of(context).textDrawerAddLocation,
                route: kRouteProfile,
              ),
              CustomTileDrawer(
                iconPath: 'minha_conta.svg',
                title: S.of(context).textDrawerMyAccount,
              ),
              CustomTileDrawer(
                iconPath: 'configuracoes.svg',
                title: S.of(context).textConfiguration,
              ),
              CustomTileDrawer(
                iconPath: 'privacidade.svg',
                title: S.of(context).textPrivacy,
              ),
              CustomTileDrawer(
                iconPath: 'termos_uso.svg',
                title: S.of(context).textTermsOfUse,
              ),
              CustomTileDrawer(
                iconPath: 'sobre.svg',
                title: S.of(context).textAbout,
              ),
              CustomTileDrawer(
                iconPath: 'contato.svg',
                title: S.of(context).textContact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
