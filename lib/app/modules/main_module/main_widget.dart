import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/utils/constants/routes.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

import 'main_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ModularState<BottomNavBar, MainBloc> {
  int _selectedPage = 0;

  final itens = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset('images/icons/home.svg'),
      activeIcon: SvgPicture.asset('images/icons/home_active.svg'),
      label: 'Início',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('images/icons/search.svg'),
      activeIcon: SvgPicture.asset('images/icons/search_active.svg'),
      label: 'Buscar',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset('images/icons/review.svg'),
      activeIcon: SvgPicture.asset('images/icons/review_active.svg'),
      label: 'Avaliações',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
  }

  void navigateToPage(int index) {
    if (index != _selectedPage) {
      if (index == 0) {
        Modular.to.navigate(kRouteMain + kRouteHome);
        //Modular.to.navigate('/main/home/');
      }
      if (index == 1) {
        Modular.to.navigate(kRouteMain + kRouteSearch);
        //Modular.to.navigate('/main/search/');
      }
      if (index == 2) {
        Modular.to.navigate(kRouteMain + kRouteProfile);
        //Modular.to.navigate('/main/profile/');
      }
      _selectedPage = index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (index) => navigateToPage(index),
        unselectedLabelStyle: TextStyles.custom(
          color: kColorButtonPrimary,
        ),
        selectedLabelStyle: TextStyles.custom(
          color: kColorButtonPrimary,
          fontWeight: FontWeight.bold,
        ),
        elevation: 15,
        showUnselectedLabels: false,
        items: itens,
      ),
    );
  }
}
