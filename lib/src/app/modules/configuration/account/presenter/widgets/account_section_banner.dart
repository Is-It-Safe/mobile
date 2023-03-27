import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class AccountSectionBanner extends StatelessWidget {
  final String text;
  const AccountSectionBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: SafeColors.generalColors.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyles.headline3(
            color: SafeColors.textColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
