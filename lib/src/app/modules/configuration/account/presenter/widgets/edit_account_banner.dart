import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

class EditAccountBanner extends StatelessWidget {
  final String text;
  const EditAccountBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyles.headline3(
            color: SafeColors.textColors.dark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
