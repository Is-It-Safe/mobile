import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/modules/auth/modules/login/presenter/bloc/login_bloc.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/state/safe_builder.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../../../generated/l10n.dart';
import '../../../../../../../core/state/safe_state.dart';

class SafeVersionAppWidget extends StatefulWidget {
  const SafeVersionAppWidget({super.key});

  @override
  State<SafeVersionAppWidget> createState() => _SafeVersionAppWidgetState();
}

class _SafeVersionAppWidgetState extends SafeState<SafeVersionAppWidget, LoginBloc> {

  @override
  void initState() {
    super.initState();
    bloc.initPackageInfo();
  }



  @override
  Widget build(BuildContext context) {

    return SafeBuilder<String>(
        stream: bloc.initPackageInfoFuture,
        builder: (packageInfo) {
          return Text('${S.current.textVersionApp} $packageInfo',
              style: TextStyles.emotionalStatus());
        });
  }
}
