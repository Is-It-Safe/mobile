import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class ShowFieldButton extends StatelessWidget {
  final void Function() onTap;
  final bool isDisplayed;
  const ShowFieldButton(
      {Key? key, required this.onTap, required this.isDisplayed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isDisplayed ? Icons.visibility : Icons.visibility_off,
        color: SafeColors.textColors.dark,
      ),
    );
  }
}
