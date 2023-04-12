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

  const SafeAppBar({
    Key? key,
    this.title = StringConstants.empty,
    this.onTap,
    this.appBarType = AppBarType.regular,
    this.hasLeading = true,
    this.bottom,
  }) : super(key: key);

  SafeAppBar home({
    Function(int)? onBottomTap,
    Function()? onOpenDrawer,
    required TabController tabController,
  }) {
    return SafeAppBar(
      title: S.current.textIsItSafe,
      appBarType: AppBarType.home,
      onTap: onOpenDrawer,
      bottom: TabBar(
        controller: tabController,
        indicatorColor: SafeColors.textColors.dark,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: onBottomTap,
        tabs: [
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => appBarType == AppBarType.home
      ? const Size.fromHeight(120)
      : const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.regular:
        return AppBar(
          backgroundColor: SafeColors.generalColors.background,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            title,
            style: TextStyles.subtitle1(),
          ),
          automaticallyImplyLeading: hasLeading,
          leading: hasLeading
              ? IconButton(
                  onPressed: onTap ?? () => Modular.to.pop(),
                  icon: SvgPicture.asset(
                    AssetConstants.icons.arrowBack,
                  ),
                )
              : null,
          bottom: bottom,
        );
      case AppBarType.home:
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
                      Row(
                        children: [
                          Image.asset(
                            AssetConstants.general.logo,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            title,
                            style: TextStyles.appBarHome(),
                          ),
                        ],
                      ),
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
  }
}
