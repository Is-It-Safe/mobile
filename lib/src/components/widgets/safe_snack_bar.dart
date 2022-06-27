import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

enum SnackBarType { active, success, alert, error, info }

class SafeSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final Icon? icon;

  const SafeSnackBar({
    Key? key,
    required this.message,
    this.type = SnackBarType.active,
    this.icon,
  }) : super(key: key);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SafeSnackBar(
          message: message,
          type: type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          icon ?? _getIcon(),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyles.bodyText2(
                color: _getTextIconColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTextIconColor() {
    switch (type) {
      case SnackBarType.alert:
        return SafeColors.generalColors.white;
      case SnackBarType.error:
        return SafeColors.generalColors.white;
      case SnackBarType.success:
        return SafeColors.generalColors.white;
      case SnackBarType.active:
        return SafeColors.generalColors.white;
      case SnackBarType.info:
        return SafeColors.generalColors.white;
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.alert:
        return SafeColors.statusColors.alert;
      case SnackBarType.error:
        return SafeColors.statusColors.error;
      case SnackBarType.success:
        return SafeColors.statusColors.success;
      case SnackBarType.active:
        return SafeColors.statusColors.active;
      case SnackBarType.info:
        return SafeColors.statusColors.info2;
    }
  }

  Icon _getIcon() {
    final iconColor = _getTextIconColor();
    switch (type) {
      case SnackBarType.alert:
        return Icon(
          Icons.admin_panel_settings_sharp,
          color: iconColor,
        );
      case SnackBarType.error:
        return Icon(
          Icons.error_outline,
          color: iconColor,
        );
      case SnackBarType.success:
        return Icon(
          Icons.check_circle_outline,
          color: iconColor,
        );
      case SnackBarType.active:
        return Icon(
          Icons.thumb_up_alt,
          color: iconColor,
        );
      case SnackBarType.info:
        return Icon(
          Icons.info_outline,
          color: iconColor,
        );
    }
  }
}
