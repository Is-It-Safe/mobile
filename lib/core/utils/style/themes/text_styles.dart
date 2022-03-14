import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

class TextStyles {
  static TextStyle custom({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: fontSize ?? 12,
    );
  }

  static TextStyle headline1({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  static TextStyle headline2({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 24,
    );
  }

  static TextStyle headline3({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle subtitle1({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: 18,
    );
  }

  static TextStyle subtitle2(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: fontSize ?? 24,
    );
  }

  static TextStyle bodyText1({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: 16,
    );
  }

  static TextStyle bodyText2({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  static TextStyle caption({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
  }

  static TextStyle helper({Color? color, double? fontSize}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 16,
    );
  }

  static TextStyle button(
      {Color? color, double? fontSize, TextDecoration? decoration}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 14,
      decoration: decoration,
    );
  }

  static TextStyle label({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
  }
}
