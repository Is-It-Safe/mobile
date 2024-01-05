// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_button.dart';
import 'package:is_it_safe_app/src/core/extentions/safe_dialog_type_extention.dart';

///O [SafeDialog] é um widget responsável por gerenciar e armazenar variádos
///tipos de dialogs.
enum SafeDialogType { success, alert, error }

class SafeButtonDialog {
  final String title;
  final Function()? onTap;
  final bool hasBackground;

  SafeButtonDialog({
    required this.title,
    this.onTap,
    this.hasBackground = true,
  });
}

typedef PrimarySafeButtonDialog = SafeButtonDialog;
typedef SecondarySafeButtonDialog = SafeButtonDialog;

class SafeDialog extends StatelessWidget {
  final String? title;
  final String message;
  final PrimarySafeButtonDialog primaryButton;
  final SecondarySafeButtonDialog? secondaryButton;
  final SafeDialogType type;
  final bool buttonHasBackground;
  final bool hasIcon;
  final Color? titleColor;
  const SafeDialog({
    Key? key,
    this.title,
    required this.message,
    required this.primaryButton,
    this.secondaryButton,
    required this.type,
    this.buttonHasBackground = true,
    this.hasIcon = true,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      title: Row(
        children: [
          if (hasIcon) type.icon,
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title ?? type.title,
              style: TextStyles.headline3(
                color: titleColor ?? type.color,
              ).copyWith(
                fontSize: size.width * .05,
                overflow: TextOverflow.clip,
              ),
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

  Widget _getOneOrTwoButtons() {
    if (secondaryButton != null) {
      return Row(
        children: [
          Expanded(
            child: SafeButton(
              title: secondaryButton?.title ?? S.current.textCancel,
              onTap: secondaryButton?.onTap ?? Modular.to.pop,
              hasBackground: secondaryButton?.hasBackground ?? false,
              style: TextStyles.button(
                color: SafeColors.buttonColors.primary,
              ),
            ),
          ),
          Expanded(
            child: SafeButton(
              title: primaryButton.title,
              onTap: primaryButton.onTap ?? Modular.to.pop,
              hasBackground: primaryButton.hasBackground,
              style: TextStyles.button(
                color: SafeColors.buttonColors.primary,
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          child: SafeButton(
            title: primaryButton.title,
            onTap: primaryButton.onTap ?? Modular.to.pop,
            hasBackground: primaryButton.hasBackground,
            style: TextStyle(color: SafeColors.buttonColors.primary),
          ),
        ),
      ],
    );
  }
}
