import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class SafeLoading extends StatelessWidget {
  const SafeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _androidLoading() : _androidLoading();
  }

  Widget _androidLoading() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: SafeColors.buttonColors.primary,
          color: SafeColors.generalColors.primary,
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _iosLoading() {
    return const Align(
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(
        animating: true,
      ),
    );
  }
}
