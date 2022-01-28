import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/helper/log.dart';

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
    return const Scaffold(
      body: Center(
        child: Text('HOME'),
      ),
    );
  }
}
