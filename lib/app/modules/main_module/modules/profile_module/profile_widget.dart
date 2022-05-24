import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/app/modules/main_module/modules/profile_module/profile_bloc.dart';
import 'package:is_it_safe_app/src/util/log_util.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);
  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends ModularState<ProfileWidget, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    LogUtil().route(Modular.to.path);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('PROFILE'),
      ),
    );
  }
}
