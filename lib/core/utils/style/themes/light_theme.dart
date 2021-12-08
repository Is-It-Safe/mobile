import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/light_theme_colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColorLight),
  scaffoldBackgroundColor: scaffoldBackgroundColorLight,
  errorColor: errorColor,
  splashColor: splashColorLight,
  disabledColor: disabledColor,
  backgroundColor: splashColorLight2,

  /// Sub themes
  textTheme: _textTheme,
  iconTheme: _iconTheme,
  inputDecorationTheme: _inputDecoration,
);

TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.bold,
  ),
  headline2: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.normal,
  ),
  headline3: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.bold,
  ),
  headline4: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.w400,
  ),
  subtitle1: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.normal,
    fontSize: 18,
  ),
  subtitle2: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  ),
  bodyText1: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.normal,
  ),
  bodyText2: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.normal,
  ),
  button: GoogleFonts.poppins(
    color: primaryTextColorLight,
    fontWeight: FontWeight.w500,
  ),
);

IconThemeData _iconTheme = const IconThemeData(
  color: primaryColor,
  size: 25,
);

InputDecorationTheme _inputDecoration = InputDecorationTheme(
  hintStyle: GoogleFonts.poppins(
    color: greyTextColorLight,
    fontWeight: FontWeight.w500,
  ),
  disabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: greyColor,
    ),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      color: greyColor,
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: greyColor,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: errorColor,
      width: 2,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: inputFocusedColor,
      width: 2,
    ),
  ),
);
