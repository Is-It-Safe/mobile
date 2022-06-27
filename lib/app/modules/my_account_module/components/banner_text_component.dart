import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class BannerText extends StatelessWidget {
  const BannerText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: SafeColors.generalColors.secondary,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          top: 12,
          bottom: 14,
        ),
        child: Text(
          title,
          style: TextStyles.bodyText1(),
        ),
      ),
    );
  }
}
