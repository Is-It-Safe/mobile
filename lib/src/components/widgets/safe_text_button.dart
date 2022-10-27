import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SafeTextButton extends StatelessWidget {
  final String text;
  void Function()? onTap;
  final String? preText;
  final String? posText;
  final Color? textColor;
  final Color? allTextColor;
  final TextStyles? textStyle;
  SafeTextButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.preText,
      this.posText,
      this.textColor,
      this.allTextColor,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text.rich(
        TextSpan(
          text: preText,
          style: textStyle != null
              ? null
              : TextStyles.bodyText1(color: allTextColor),
          children: [
            TextSpan(
              text: ' $text',
              style: textStyle != null
                  ? null
                  : TextStyles.bodyText1(
                      color: textColor,
                      textDecoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
            TextSpan(
              text: posText,
              style: textStyle != null
                  ? null
                  : TextStyles.bodyText1(color: allTextColor),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
