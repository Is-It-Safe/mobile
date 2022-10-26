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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _firstText(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _thirdText(context),
            _secondText(context),
          ],
        ),
      ],
    );
  }

  Widget _firstText(BuildContext context) {
    return Text(
      preText ?? StringConstants.empty,
      //TODO: corrigir o style
      style:
          textStyle != null ? null : TextStyles.bodyText1(color: allTextColor),
      //style: TextStyles.bodyText1(color: allTextColor),
    );
  }

  Widget _secondText(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        //TODO: corrigir o style
        style: textStyle != null
            ? null
            : TextStyles.bodyText1(
                color: textColor, textDecoration: TextDecoration.underline),
        //style: TextStyles.bodyText1(color: textColor, textDecoration: TextDecoration.underline),
      ),
    );
  }

  Widget _thirdText(BuildContext context) {
    return Text(
      posText ?? StringConstants.empty,
      //TODO: corrigir o style
      style:
          textStyle != null ? null : TextStyles.bodyText1(color: allTextColor),
      //style: TextStyles.bodyText1(color: allTextColor),
    );
  }
}
