import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/theme_state.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ThemeState>(context).theme == ThemeType.DARK,
      activeColor: kColorButtonPrimary,
      inactiveTrackColor: kColorButtonInactive,
      onChanged: (value) {
        Provider.of<ThemeState>(context, listen: false).theme =
            value ? ThemeType.DARK : ThemeType.LIGHT;
      },
    );
  }
}
