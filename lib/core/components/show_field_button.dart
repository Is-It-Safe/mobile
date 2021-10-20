import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/helper/helpers.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';

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
      child: IconTheme(
        data: Theme.of(context).iconTheme.copyWith(
                color: Helpers.getColorFromTheme(
              context: context,
              darkModeColor: scaffoldBackgroundColorLight,
              lightModeColor: scaffoldBackgroundColorDark,
            )),
        child: Icon(
          isDisplayed ? Icons.visibility : Icons.visibility_off,
        ),
      ),
    );
  }
}
