import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';

///O [TextStyles] é uma classe responsável por gerenciar e armazenar variádos
///tipos de estilização de textos.
class TextStyles {
  ///Método que retorna estilização de texto de forma customizável.
  ///
  ///Deve ser utilizado somente caso os outros métodos da
  ///classe [TextStyles] não contemplem a estilização de texto proposto no design.
  ///
  ///**Exemplo:**
  /// ```dart
  /// Text(
  ///   'texto',
  ///   style: TextStyles.custom(
  ///     color: kColorStatusActive,
  ///     fontWeight: FontWeight.bold,
  ///     fontSize: 13,
  ///    ),
  /// ),
  /// ```
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

  ///Método que retorna estilização de texto correspondente ao **Headline 1**.
  static TextStyle headline1({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Headline 2**.
  static TextStyle headline2({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 24,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Headline 3**.
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

  ///Método que retorna estilização de texto correspondente ao **Subtitle 2**.
  static TextStyle subtitle2(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontSize: fontSize ?? 24,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **BodyText 1**.
  static TextStyle bodyText1({Color? color, FontWeight? fontWeight}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: 16,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **BodyText 2**.
  static TextStyle bodyText2({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Caption**.
  static TextStyle caption({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w300,
      fontSize: 12,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Helper**.
  static TextStyle helper({Color? color, double? fontSize}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 16,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Button**.
  static TextStyle button(
      {Color? color, double? fontSize, TextDecoration? decoration}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 14,
      decoration: decoration,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Label**.
  static TextStyle label({Color? color}) {
    return GoogleFonts.poppins(
      color: color ?? kColorTextLight,
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
  }
}
