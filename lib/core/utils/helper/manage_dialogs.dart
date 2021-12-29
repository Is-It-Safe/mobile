import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerDialogs {
  static void showErrorDialog(BuildContext context, String message) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            "Atenção!",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Ok",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("Atenção!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    }
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: Center(
            child: Platform.isIOS ? _iosLoading() : _androidLoading(context),
          ),
        ),
      ),
    );
  }

  static _iosLoading() {
    return const CupertinoActivityIndicator(
      animating: true,
    );
  }

  static _androidLoading(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
      ),
    );
  }
}
