import 'package:flutter/material.dart';

import '../../../../core/utils/style/colors/general_colors.dart';
import '../../../../src/app/components/style/text_styles.dart';

class BannerText extends StatelessWidget {
  const BannerText({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kColorSecondaryLight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          top: 12,
          bottom: 14,
        ),
        child: Text(
          title,
          style: TextStyles.custom(
            color: kColorPrimaryLight,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
