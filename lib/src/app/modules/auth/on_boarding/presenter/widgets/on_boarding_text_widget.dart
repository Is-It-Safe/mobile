import 'package:flutter/material.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class TextOnBoarding3 extends StatelessWidget {
  const TextOnBoarding3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textOnBoarding3_0 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding3_1 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding3_2 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class TextOnBoarding2 extends StatelessWidget {
  const TextOnBoarding2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textOnBoarding2_0 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding2_1 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class TextOnBoarding1 extends StatelessWidget {
  const TextOnBoarding1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: S.current.textOnBoarding1_0 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding1_1 + StringConstants.space,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding1_2 + StringConstants.space,
            style: TextStyles.headline2(
              fontWeight: FontWeight.normal,
              color: SafeColors.textColors.white,
            ),
          ),
          TextSpan(
            text: S.current.textOnBoarding1_3 + StringConstants.dot,
            style: TextStyles.headline2(
              color: SafeColors.textColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
