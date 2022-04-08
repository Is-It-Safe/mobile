import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class ActionTextComponent extends StatelessWidget {
  const ActionTextComponent(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.isLastItem = false})
      : super(
          key: key,
        );
  final String title;
  final VoidCallback onPressed;
  final bool isLastItem;

  get kColorTextLight => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLastItem ? 0 : 40),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyles.subtitle1(color: kColorSecondaryLight),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: kColorSecondaryLight,
            ),
          )
        ],
      ),
    );
  }
}
