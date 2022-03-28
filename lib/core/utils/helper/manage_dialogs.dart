import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_it_safe_app/core/utils/style/all.dart';
import 'package:is_it_safe_app/generated/l10n.dart';

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

  static void showSuccessFeedbackDialog(
    BuildContext context, {
    required String title,
    String? message,
    required Function() onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: kColorBackgroundLight,
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 46, vertical: 15),
                child: SvgPicture.asset(
                  'images/illustrations/success_feedback.svg',
                ),
              ),
              Text(
                title,
                style: TextStyles.headline3(
                  color: kColorReviewSuccess,
                ),
              ),
              message == null
                  ? const SizedBox.shrink()
                  : Text(
                      message,
                      style: TextStyles.helper(),
                      textAlign: TextAlign.center,
                    ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: onPressed,
                child: Text(
                  S.of(context).textContinue,
                  style: TextStyles.button(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
