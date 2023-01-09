import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/account/presenter/pages/account_page.dart';
import 'package:is_it_safe_app/src/app/modules/configuration/configuration_module.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_profile_avatar.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class HomeDrawer extends StatelessWidget {
  final String? image;
  final String? name;
  final String? icon;
  final String? text;
  final String? route;
  const HomeDrawer({
    Key? key,
    this.image = PlaceHolderAssets.profileAvatar,
    this.name,
    this.icon,
    this.text,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 60,
          ),
          child: Column(
            children: [
              DrawerHeader(
                image: image,
                name: name,
              ),
              const SizedBox(height: 90),

              // Minha Conta
              DrawerItem(
                icon: AssetConstants.icons.account,
                text: S.current.textDrawerMyAccount,
                route: ConfigurationModule.route + AccountPage.route,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SafeProfileAvatar(
          image: image!,
          size: 60,
        ),
        const SizedBox(width: 25),
        Visibility(
          visible: name != null,
          child: Expanded(
            child: Text(
              name ?? StringConstants.empty,
              style: TextStyles.subtitle1(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.route,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final String route;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed(route),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 15),
          Text(
            text,
            style: TextStyles.subtitle1(),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
