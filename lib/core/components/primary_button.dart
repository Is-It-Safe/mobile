import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final Function()? onTap;
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 56,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color ?? kColorButtonPrimary,
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
