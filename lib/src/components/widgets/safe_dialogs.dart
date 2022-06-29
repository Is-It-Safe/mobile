import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

///O [SafeDialog] é um widget responsável por gerenciar e armazenar variádos
///tipos de dialogs.
class SafeDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? onTap;
  const SafeDialog({
    Key? key,
    this.title,
    this.message,
    this.onTap,
  }) : super(key: key);

  Widget error() {
    return this;
  }

  Widget show() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return _mountAndroidDialog();
    } else {
      return _mountIOSDialog();
    }
  }

  Widget _mountAndroidDialog() {
    return AlertDialog(
      backgroundColor: SafeColors.generalColors.background,
      title: Text(
        title ?? S.current.textError,
        style: TextStyles.subtitle1(),
      ),
      content: Text(message ?? S.current.textErrorTryAgain),
      actions: <Widget>[
        TextButton(
          child: Text(
            S.current.textOk,
            style: TextStyles.button(),
          ),
          //TODO Fix Button: pop não funciona de forma apropriada
          onPressed: onTap ?? () => Modular.to.canPop(),
        )
      ],
    );
  }

  Widget _mountIOSDialog() {
    return CupertinoAlertDialog(
      title: Text(
        title ?? S.current.textError,
        style: TextStyles.subtitle1(),
      ),
      content: Text(message ?? S.current.textErrorTryAgain),
      actions: <Widget>[
        TextButton(
          child: Text(S.current.textOk),
          //TODO Fix Button: pop não funciona de forma apropriada
          onPressed: onTap ?? () => Modular.to.canPop(),
        )
      ],
    );
  }
}

@Deprecated('Use SafeDialog.show()')
class SafeDialogs {
  ///O [dialog] é um método responsável por exibir um dialog de alerta.
  @Deprecated('Use SafeDialog.show()')
  static Widget dialog({
    required String title,
    required String message,
    Function()? onTap,
  }) {
    if (Platform.isAndroid) {
      return _androidDialog(
        title: title,
        message: message,
        onTap: onTap,
      );
    } else {
      return _iosDialog(
        title: title,
        message: message,
        onTap: onTap,
      );
    }
  }

  static Widget _androidDialog({
    required String title,
    required String message,
    Function()? onTap,
  }) {
    return AlertDialog(
      backgroundColor: SafeColors.generalColors.background,
      title: Text(
        title,
        style: TextStyles.subtitle1(),
      ),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(
            S.current.textOk,
            style: TextStyles.button(),
          ),
          onPressed: onTap ?? () => Modular.to.pop(),
        )
      ],
    );
  }

  static Widget _iosDialog({
    required String title,
    required String message,
    Function()? onTap,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(S.current.textOk),
          onPressed: onTap ?? () => Modular.to.canPop(),
        )
      ],
    );
  }

  ///Método responsável por emitir um dialog de erro.
  @Deprecated('Use SafeDialog.error()')
  static Widget error({String? message}) {
    if (Platform.isAndroid) {
      return _androidErrorDialog(message);
    } else {
      return _iosErrorDialog(message);
    }
  }

  static Widget _androidErrorDialog(String? message) {
    return AlertDialog(
      backgroundColor: SafeColors.generalColors.background,
      title: Text(
        S.current.textError,
        style: TextStyles.subtitle1(),
      ),
      content: Text(message ?? S.current.textErrorTryAgain),
      actions: <Widget>[
        TextButton(
          child: Text(
            S.current.textOk,
            style: TextStyles.button(),
          ),
          onPressed: () => Modular.to.pop(),
        )
      ],
    );
  }

  static Widget _iosErrorDialog(String? message) {
    return CupertinoAlertDialog(
      title: Text(S.current.textError),
      content: Text(message ?? S.current.textErrorTryAgain),
      actions: <Widget>[
        TextButton(
          child: Text(S.current.textOk),
          onPressed: () => Modular.to.canPop(),
        )
      ],
    );
  }
}
