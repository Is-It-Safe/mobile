import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/home_module/home_bloc.dart';
import 'package:is_it_safe_app/app/modules/profile_module/profile_bloc.dart';

class ProfileWidget extends StatefulWidget {
  final String title;
  const ProfileWidget({Key? key, this.title = 'HomePagePage'})
      : super(key: key);
  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends ModularState<ProfileWidget, ProfileBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('PROFILE'),
      ),
    );
  }
}
