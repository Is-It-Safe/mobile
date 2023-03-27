import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class AccountInfoTile extends StatelessWidget {
  final String title;
  final String? value;
  const AccountInfoTile({
    Key? key,
    required this.title,
    this.value = StringConstants.hyphen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.subtitle1(),
        ),
        const SizedBox(height: 2),
        Text(
          value ?? StringConstants.hyphen,
          style: TextStyles.subtitle1(
            color: SafeColors.textColors.label,
          ),
        ),
      ],
    );
  }
}
