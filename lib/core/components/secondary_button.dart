import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/src/app/components/style/text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final Function()? onTap;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Color? textColor;
  final String text;

  const SecondaryButton({
    Key? key,
    this.onTap,
    this.height,
    this.width,
    this.borderColor,
    this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 120,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? kColorButtonPrimary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyles.button(color: textColor),
          ),
        ),
      ),
    );
  }
}
