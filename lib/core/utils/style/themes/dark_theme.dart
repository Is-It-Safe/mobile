import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColorDark),
  scaffoldBackgroundColor: scaffoldBackgroundColorDark,
  errorColor: errorColor,
  splashColor: splashColorDark,
  disabledColor: disabledColor,

  /// Sub themes
  textTheme: _textTheme,
  iconTheme: _iconTheme,
  inputDecorationTheme: _inputDecoration,
);

TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.bold,
  ),
  headline2: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.normal,
  ),
  headline3: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.bold,
  ),
  headline4: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.w400,
  ),
  headline5: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.w400,
  ),
  subtitle1: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.normal,
    fontSize: 18,
  ),
  subtitle2: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  ),
  bodyText1: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.normal,
  ),
  bodyText2: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.normal,
  ),
  button: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.w500,
  ),
);

IconThemeData _iconTheme = const IconThemeData(
  color: primaryColor,
  size: 25,
);

InputDecorationTheme _inputDecoration = InputDecorationTheme(
  hintStyle: GoogleFonts.poppins(
    color: primaryTextColorDark,
    fontWeight: FontWeight.w500,
  ),
  disabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
    ),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
    ),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
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
