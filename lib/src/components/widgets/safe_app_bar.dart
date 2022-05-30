import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';

enum AppBarType { regular, home }

class SafeAppBar extends StatelessWidget with PreferredSizeWidget {
  final AppBarType appBarType;
  final String title;
  final bool hasLeading;
  final Function()? onTap;

  const SafeAppBar({
    Key? key,
    required this.title,
    this.onTap,
    this.appBarType = AppBarType.regular,
    this.hasLeading = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.regular:
        return _mountRegularAppBar();
      case AppBarType.home:
        return _mountHomeAppBar();
    }
  }

  AppBar _mountRegularAppBar() {
    return AppBar(
      backgroundColor: SafeColors.generalColors.background,
      elevation: 0.0,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyles.subtitle1(),
      ),
      leading: _mountLeading(),
    );
  }

  Widget? _mountLeading() {
    if (hasLeading) {
      return IconButton(
        onPressed: onTap ?? () => Modular.to.pop(),
        icon: SvgPicture.asset(
          AssetConstants.backButtonIcon,
        ),
      );
    }
    return null;
  }

  Center _mountHomeAppBar() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: SafeColors.generalColors.background,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _moundAppBarHomeTitle(),
            IconButton(
              onPressed: onTap,
              icon: SvgPicture.asset(
                AssetConstants.drawerIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moundAppBarHomeTitle() {
    return Row(
      children: [
        Image.asset(
          AssetConstants.logo,
          height: 30,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyles.appBarHome(),
        ),
      ],
    );
  }
}
