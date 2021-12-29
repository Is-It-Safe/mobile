import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_material_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

ThemeData lightTheme = ThemeData(

  scaffoldBackgroundColor: kColorBackgroundLight,
  errorColor: kColorStatusError,
  primarySwatch: kMaterialColorButtonPrimary,
  primaryColor: kColorStatusActive,

  inputDecorationTheme: _inputDecoration,
);

InputDecorationTheme _inputDecoration = InputDecorationTheme(
  hintStyle: TextStyles.helper(),
  disabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: kColorTextLight,
      width: 1,
    ),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      color: kColorTextLight,
      width: 1,
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: kColorTextLight,
      width: 1,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: kColorStatusError,
      width: 1,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: kColorStatusActive,
      width: 1,
    ),
  ),
);
