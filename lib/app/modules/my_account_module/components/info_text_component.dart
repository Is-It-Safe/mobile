import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class InfoTextComponent extends StatelessWidget {
  const InfoTextComponent({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.subtitle1(),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          value,
          style: TextStyles.subtitle1(color: SafeColors.textColors.label),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
