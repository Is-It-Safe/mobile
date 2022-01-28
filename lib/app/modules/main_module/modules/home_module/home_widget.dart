import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

import 'components/cards/local_card.dart';
import 'components/cards/local_card_image.dart';
import 'components/drawer/custom_drawer.dart';
import 'home_bloc.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends ModularState<HomeWidget, HomeBloc> {
  @override
  void initState() {
    super.initState();
    Log.route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: kColorBackgroundLight,
          title: Row(
            children: [
              Image.asset(
                'images/app_icon.png',
                width: 35,
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  S.of(context).textIsItSafe,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: kColorTextLight,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textClosePlaces,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textBestRates,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: const [
                LocalCardImage(),
                SizedBox(height: 10),
                LocalCard(),
              ],
            ),
            Container(
              color: Colors.green,
              height: 50,
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
