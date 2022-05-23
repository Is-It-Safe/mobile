import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

AppBar appBar({
  required BuildContext context,
  required String title,
  required bool hasLeading,
  Color? backgroundColor,
  double? height,
}) {
  return AppBar(
    toolbarHeight: height ?? 97,
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: 0.0,
    automaticallyImplyLeading: hasLeading,
    title: Text(
      title,
      style: TextStyles.subtitle1(),
    ),
    leading: hasLeading
        ? IconButton(
            onPressed: () => Modular.to.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 17,
              color: kColorTextLight,
            ),
          )
        : null,
  );
}
