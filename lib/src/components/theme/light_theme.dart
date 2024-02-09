import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: SafeColors.generalColors.background,
  primarySwatch: SafeColors.materialButtonColors.primary,
  primaryColor: SafeColors.statusColors.active,
  dialogBackgroundColor: SafeColors.generalColors.background,
  inputDecorationTheme: _inputDecoration,
);

InputDecorationTheme _inputDecoration = InputDecorationTheme(
  hintStyle: TextStyles.helper(),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: SafeColors.textColors.dark,
      width: 1,
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: SafeColors.textColors.dark,
      width: 1,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: SafeColors.textColors.dark,
      width: 1,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: SafeColors.statusColors.error,
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: SafeColors.statusColors.active,
      width: 1,
    ),
  ),
);
