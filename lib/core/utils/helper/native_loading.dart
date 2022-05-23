import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class NativeLoading extends StatelessWidget {
  final bool? animating;

  const NativeLoading({
    Key? key,
    this.animating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _iosLoading() : _androidLoading(context);
  }

  _iosLoading() {
    return const Align(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
  }

  _androidLoading(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: kColorButtonPrimary,
        color: kColorPrimaryLight,
      ),
    );
  }
}
