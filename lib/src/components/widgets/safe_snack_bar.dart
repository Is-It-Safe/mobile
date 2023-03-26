import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/enum/safe_snackbar_type_enum.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:overlay_support/overlay_support.dart';

abstract class ISafeSnackBar {
  void info(String message);
  void error(String message);
  void alert(String message);
  void success(String message);
  void active(String message);
}

class SafeSnackBar implements ISafeSnackBar {
  OverlaySupportEntry? overlaySupportEntry;
  final duration = const Duration(seconds: 3);

  @override
  void active(String message) {
    overlaySupportEntry = showOverlayNotification(
      (context) {
        return SafeSnackBarImpl(
          type: SafeSnackBarTypeEnum.active,
          message: message,
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }

  @override
  void alert(String message) {
    overlaySupportEntry = showOverlayNotification(
      (context) {
        return SafeSnackBarImpl(
          type: SafeSnackBarTypeEnum.alert,
          message: message,
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }

  @override
  void error(String message) {
    overlaySupportEntry = showOverlayNotification(
      (context) {
        return SafeSnackBarImpl(
          type: SafeSnackBarTypeEnum.error,
          message: message,
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }

  @override
  void info(String message) {
    overlaySupportEntry = showOverlayNotification(
      (context) {
        return SafeSnackBarImpl(
          type: SafeSnackBarTypeEnum.info,
          message: message,
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }

  @override
  void success(String message) {
    overlaySupportEntry = showOverlayNotification(
      (context) {
        return SafeSnackBarImpl(
          type: SafeSnackBarTypeEnum.success,
          message: message,
        );
      },
      position: NotificationPosition.bottom,
      duration: duration,
    );
  }
}

class SafeSnackBarImpl extends StatelessWidget {
  final String message;
  final Icon? icon;
  final SafeSnackBarTypeEnum type;
  const SafeSnackBarImpl({
    Key? key,
    required this.message,
    required this.type,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: type.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              icon ?? type.icon,
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  message,
                  style: TextStyles.bodyText2(
                    color: SafeColors.generalColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
