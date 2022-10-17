import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SafeTextButton extends StatelessWidget {
  final String text;
  void Function()? onTapSign;
  void Function()? onTapPass;
  final String? preText;
  final String? posText;
  final Color? textColor;
  final Color? allTextColor;
  final TextStyles? textStyle;
  SafeTextButton(
      {Key? key,
      required this.text,
      required this.onTapSign,
      required this.onTapPass,
      this.preText,
      this.posText,
      this.textColor,
      this.allTextColor,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _firstText(context),
        _secondText(context),
      ],
    );
  }

  Widget _firstText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          preText ?? StringConstants.empty,
          style: TextStyles.bodyText1(
            color: allTextColor,
          ),
        ),
        GestureDetector(
          onTap: onTapSign,
          child: Text(
            posText ?? StringConstants.empty,
            style: TextStyles.bodyText1(
              color: textColor,
              textDecoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _secondText(BuildContext context) {
    return GestureDetector(
      onTap: onTapPass,
      child: Text(
        text,
        style: TextStyles.bodyText1(
          color: allTextColor,
          textDecoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
