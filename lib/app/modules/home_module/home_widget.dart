import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/components/local_card.dart';
import 'package:is_it_safe_app/app/modules/home_module/components/local_card_image.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_bloc.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends ModularState<HomeWidget, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteBackgroundColor,
          title: Row(
            children: [
              Image.asset('images/app_icon.png',width: 35,height: 35,),
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
            indicatorColor: darkSecondary,
            indicatorSize: TabBarIndicatorSize.tab,
            
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textHomeTab1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  S.of(context).textHomeTab2,
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
            Container(
              color: whiteBackgroundColor,
              child: Column(
                children: [
                  LocalCardImage(),
                  SizedBox(height: 10,),
                  LocalCard(),
                ],
              ),
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
