import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

enum AppBarType { regular, home }

class SafeAppBar extends StatelessWidget with PreferredSizeWidget {
  final AppBarType appBarType;
  final String title;
  final bool hasLeading;
  final PreferredSizeWidget? bottom;
  final Function()? onTap;
  final Function()? onLogoIconTap;

  const SafeAppBar({
    Key? key,
    this.title = StringConstants.empty,
    this.onTap,
    this.appBarType = AppBarType.regular,
    this.hasLeading = true,
    this.bottom,
    this.onLogoIconTap,
  }) : super(key: key);

  SafeAppBar home({
    Function(int)? onBottomTap,
    Function()? onOpenDrawer,
    Function()? onLogoIconTap,
  }) {
    return SafeAppBar(
      title: S.current.textIsItSafe,
      appBarType: AppBarType.home,
      onTap: onOpenDrawer,
      onLogoIconTap: () => onLogoIconTap != null ? onLogoIconTap() : Future(() => null),
      bottom: TabBar(
        indicatorColor: SafeColors.textColors.dark,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: onBottomTap,
        tabs: _mountHomeBottomTabs(),
      ),
    );
  }

  List<Widget> _mountHomeBottomTabs() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          S.current.textClosePlaces,
          style: TextStyles.bodyText2(
            color: SafeColors.textColors.dark,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          S.current.textBestRates,
          style: TextStyles.bodyText2(
            color: SafeColors.textColors.dark,
          ),
        ),
      ),
    ];
  }

  @override
  Size get preferredSize => appBarType == AppBarType.home
      ? const Size.fromHeight(120)
      : const Size.fromHeight(90);

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
      automaticallyImplyLeading: hasLeading,
      leading: _mountLeading(),
      bottom: bottom,
    );
  }

  Widget? _mountLeading() {
    if (hasLeading) {
      return IconButton(
        onPressed: onTap ?? () => Modular.to.pop(),
        icon: SvgPicture.asset(
          AssetConstants.icons.arrowBack,
        ),
      );
    }
    return null;
  }

  Center _mountHomeAppBar() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: SafeColors.generalColors.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _moundAppBarHomeTitle(),
                  IconButton(
                    onPressed: onTap,
                    icon: SvgPicture.asset(
                      AssetConstants.icons.drawer,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: bottom!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _moundAppBarHomeTitle() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onLogoIconTap != null
              ? onLogoIconTap!()
              : Future(
                  () => null,
                ),
          child: Image.asset(
            AssetConstants.general.logo,
            height: 30,
          ),
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
