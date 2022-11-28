// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';

///O [SafeDialog] é um widget responsável por gerenciar e armazenar variádos
///tipos de dialogs.
enum SafeDialogType { success, alert, error }

class SafeDialogButton {
  final String text;
  final Function()? onTap;
  const SafeDialogButton({
    required this.text,
    this.onTap,
  });
}

class SafeDialog extends StatelessWidget {
  final String? title;
  final String message;
  final SafeButton primaryBtn;
  final SafeButton? secondaryBtn;
  final SafeDialogType type;
  const SafeDialog({
    Key? key,
    this.title,
    this.secondaryBtn,
    required this.message,
    required this.primaryBtn,
    required this.type,
  }) : super(key: key);

  Widget error() {
    return this;
  }

  Widget show() {
    return this;
  }

  String _getTitleByType() {
    switch (type) {
      case SafeDialogType.success:
        return S.current.textSafeDialogTypeSucces;
      case SafeDialogType.alert:
        return S.current.textSafeDialogTypeAlert;
      case SafeDialogType.error:
        return S.current.textSafeDialogTypeError;
    }
  }

  Color _getColorByType() {
    switch (type) {
      case SafeDialogType.success:
        return SafeColors.statusColors.success;
      case SafeDialogType.alert:
        return SafeColors.statusColors.alert;
      case SafeDialogType.error:
        return SafeColors.statusColors.error;
    }
  }

  Icon _getIconByType() {
    final iconColor = _getColorByType();
    switch (type) {
      case SafeDialogType.success:
        return Icon(
          Icons.check_circle,
          color: iconColor,
        );
      case SafeDialogType.alert:
        return Icon(
          Icons.error,
          color: iconColor,
        );
      case SafeDialogType.error:
        return Icon(
          Icons.highlight_remove,
          color: iconColor,
          size: 50,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SafeColors.generalColors.background,
      title: Row(
        children: [
          _getIconByType(),
          const SizedBox(width: 10),
          Text(
            title ?? _getTitleByType(),
            style: TextStyles.headline3(
              color: _getColorByType(),
            ),
          ),
        ],
      ),
      content: Text(message),
      actions: <Widget>[
        secondaryBtn != null
            ? Row(
                children: [
                  Expanded(
                    child: SafeButton(
                      title: secondaryBtn?.title ?? S.current.textCancel,
                      onTap: secondaryBtn?.onTap ?? Modular.to.pop,
                      hasBackground: false,
                    ),
                  ),
                  Expanded(
                    child: SafeButton(
                      title: primaryBtn.title ?? S.current.textOk,
                      onTap: primaryBtn.onTap ?? Modular.to.pop,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: SafeButton(
                      title: primaryBtn.title ?? S.current.textOk,
                      onTap: primaryBtn.onTap ?? Modular.to.pop,
                    ),
                  ),
                ],
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
          onPressed: onTap ?? () => Modular.to.pop(),
          child: Text(
            S.current.textOk,
            style: TextStyles.button(),
          ),
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
          onPressed: onTap ?? () => Modular.to.canPop(),
          child: Text(S.current.textOk),
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
