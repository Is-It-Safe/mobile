import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

enum SafeSnackBarTypeEnum {
  active,
  success,
  alert,
  error,
  info,
}

extension SnackBarBackgroundColor on SafeSnackBarTypeEnum {
  Color get text {
    switch (this) {
      case SafeSnackBarTypeEnum.alert:
        return SafeColors.generalColors.primary;
      case SafeSnackBarTypeEnum.error:
        return SafeColors.generalColors.white;
      case SafeSnackBarTypeEnum.success:
        return SafeColors.generalColors.white;
      case SafeSnackBarTypeEnum.active:
        return SafeColors.generalColors.white;
      case SafeSnackBarTypeEnum.info:
        return SafeColors.generalColors.white;
    }
  }

  Color get background {
    switch (this) {
      case SafeSnackBarTypeEnum.alert:
        return SafeColors.statusColors.alert;
      case SafeSnackBarTypeEnum.error:
        return SafeColors.statusColors.error;
      case SafeSnackBarTypeEnum.success:
        return SafeColors.statusColors.success;
      case SafeSnackBarTypeEnum.active:
        return SafeColors.statusColors.active;
      case SafeSnackBarTypeEnum.info:
        return SafeColors.statusColors.info2;
    }
  }
}

extension ParseToIcon on SafeSnackBarTypeEnum {
  Icon get icon {
    final color = SafeColors.generalColors.white;
    switch (this) {
      case SafeSnackBarTypeEnum.alert:
        return Icon(Icons.admin_panel_settings_sharp, color: color);
      case SafeSnackBarTypeEnum.error:
        return Icon(Icons.error_outline, color: color);
      case SafeSnackBarTypeEnum.success:
        return Icon(Icons.check_circle_outline, color: color);
      case SafeSnackBarTypeEnum.active:
        return Icon(Icons.thumb_up_alt, color: color);
      case SafeSnackBarTypeEnum.info:
        return Icon(Icons.info_outline, color: color);
    }
  }
}
