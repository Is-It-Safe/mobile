import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/src/app/modules/home/presenter/bloc/home_bloc.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_app_bar.dart';
import 'package:is_it_safe_app/src/core/util/log_util.dart';

class HomePage extends StatefulWidget {
  static const route = '/home/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const SafeAppBar().home(
          onBottomTap: (tab) {
            // if (tab == 0) controller.getClosePlacesLocations();
            if (tab == 1) controller.getBestRatedLocations();
          },
        ),
        body: TabBarView(
          children: [
            Container(
              child: const Text('Tab 1'),
              color: Colors.blue,
            ),
            Container(
              child: const Text('Tab 2'),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
