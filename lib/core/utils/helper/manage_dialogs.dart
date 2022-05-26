import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/src/app/components/style/text_styles.dart';

///O [ManagerDialogs] é uma classe responsável por gerenciar e armazenar variádos
///tipos de dialogs.
class ManagerDialogs {
  ///Método responsável por emitir um dialog de erro.
  static void showErrorDialog(BuildContext context, String message) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: kColorBackgroundLight,
          title: Text(
            "Atenção!",
            style: TextStyles.button(fontSize: 14),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Ok",
                style: TextStyles.button(fontSize: 14),
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

  ///Método responsável por emitir um dialog de sucesso.
  static void showSuccessDialog(BuildContext context,
      {required String title, required String message, Function()? onPressed}) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: kColorBackgroundLight,
          title: Text(
            title,
            style: TextStyles.button(fontSize: 14),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Ok",
                style: TextStyles.button(fontSize: 14),
              ),
              onPressed: onPressed ??
                  () {
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
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
            )
          ],
        ),
      );
    }
  }
}
