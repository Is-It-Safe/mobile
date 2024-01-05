import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/widgets/safe_dialogs.dart';

extension SafeDialogsTypeExtention on SafeDialogType {
  String get title {
    switch (this) {
      case SafeDialogType.success:
        return S.current.textSafeDialogTypeSucces;
      case SafeDialogType.alert:
        return S.current.textSafeDialogTypeAlert;
      case SafeDialogType.error:
        return S.current.textSafeDialogTypeError;
    }
  }

  Color get color {
    switch (this) {
      case SafeDialogType.success:
        return SafeColors.statusColors.success;
      case SafeDialogType.alert:
        return SafeColors.statusColors.alert;
      case SafeDialogType.error:
        return SafeColors.statusColors.error;
    }
  }

  Icon get icon {
    switch (this) {
      case SafeDialogType.success:
        return Icon(
          Icons.check_circle,
          color: color,
        );
      case SafeDialogType.alert:
        return Icon(
          Icons.error,
          color: color,
        );
      case SafeDialogType.error:
        return Icon(
          Icons.highlight_remove,
          color: color,
          size: 50,
        );
    }
  }
}
