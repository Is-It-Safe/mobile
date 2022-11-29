// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';

///O [SafeDialog] é um widget responsável por gerenciar e armazenar variádos
///tipos de dialogs.
enum SafeDialogType { success, alert, error }

class SafeDialog extends StatelessWidget {
  final String? title;
  final String message;
  final SafeButton primaryBtn;
  final SafeButton? secondaryBtn;
  final SafeDialogType type;
  const SafeDialog({
    Key? key,
    this.title,
    required this.message,
    required this.primaryBtn,
    this.secondaryBtn,
    required this.type,
  }) : super(key: key);

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
        _getOneOrTwoButtons(),
      ],
    );
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

  Widget _getOneOrTwoButtons() {
    if (secondaryBtn != null) {
      return Row(
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
      );
    }
    return Row(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          child: SafeButton(
            title: primaryBtn.title ?? S.current.textOk,
            onTap: primaryBtn.onTap ?? Modular.to.pop,
            hasBackground: false,
            style: TextStyle(
              color: SafeColors.buttonColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
