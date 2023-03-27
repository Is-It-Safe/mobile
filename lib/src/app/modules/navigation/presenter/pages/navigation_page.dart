import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/pages/home_page.dart';
import 'package:is_it_safe_app/src/app/modules/navigation/presenter/bloc/navigation_bloc.dart';
import 'package:is_it_safe_app/src/app/modules/profile/presenter/pages/profile_page.dart';
import 'package:is_it_safe_app/src/app/modules/search/presenter/pages/search_page.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/assets_constants.dart';
import 'package:is_it_safe_app/src/core/util/safe_log_util.dart';

class NavigationPage extends StatefulWidget {
  static const route = '/app';
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState
    extends ModularState<NavigationPage, NavigationBloc> {
  int _selectedPage = 0;

  final itens = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(AssetConstants.icons.home),
      activeIcon: SvgPicture.asset(
        AssetConstants.icons.homeOutlined,
        color: SafeColors.buttonColors.primary,
      ),
      label: S.current.textBottomNavBarHome,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(AssetConstants.icons.search),
      activeIcon: SvgPicture.asset(AssetConstants.icons.searchOutlined),
      label: S.current.textBottomNavBarSearch,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(AssetConstants.icons.review),
      activeIcon: SvgPicture.asset(AssetConstants.icons.reviewOutlined),
      label: S.current.textBottomNavBarReviews,
    ),
  ];

  @override
  void initState() {
    super.initState();
    SafeLogUtil.instance.route(Modular.to.path);
  }

  void navigateToPage(int index) {
    if (index != _selectedPage) {
      if (index == 0) {
        Modular.to.navigate(NavigationPage.route + HomePage.route);
      }
      if (index == 1) {
        Modular.to.navigate(NavigationPage.route + SearchPage.route);
      }
      if (index == 2) {
        Modular.to.navigate(NavigationPage.route + ProfilePage.route);
      }
      _selectedPage = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) => navigateToPage(index),
        unselectedLabelStyle: TextStyles.label(
          color: SafeColors.buttonColors.primary,
        ),
        selectedLabelStyle: TextStyles.label(
          color: SafeColors.buttonColors.primary,
          fontWeight: FontWeight.bold,
        ),
        elevation: 15,
        showUnselectedLabels: false,
        items: itens,
      ),
    );
  }
}
