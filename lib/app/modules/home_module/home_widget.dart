import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_bloc.dart';

class HomeWidget extends StatefulWidget {
  final String title;
  const HomeWidget({Key? key, this.title = 'HomePagePage'}) : super(key: key);
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends ModularState<HomeWidget, HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HOME'),
      ),
    );
  }
}
