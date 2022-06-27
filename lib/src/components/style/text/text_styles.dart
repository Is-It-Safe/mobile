import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/font_size.dart';

///O [TextStyles] é uma classe responsável por gerenciar e armazenar variádos
///tipos de estilização de textos.
///**Exemplo:**
/// ```dart
/// Text(
///   'texto',
///   style: TextStyles.headline1(),
/// ),
/// ```
class TextStyles {
  ///Método que retorna estilização de texto correspondente ao **Headline 1**.
  static TextStyle headline1({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: fontWeight ?? FontWeight.bold,
      decoration: textDecoration,
      fontSize: FontSize.xxxxLarge,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Headline 2**.
  static TextStyle headline2({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: textDecoration,
      fontSize: FontSize.xxxLarge,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Headline 3**.
  static TextStyle headline3({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: fontWeight ?? FontWeight.bold,
      decoration: textDecoration,
      fontSize: FontSize.xLarge,
    );
  }

  static TextStyle subtitle1({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.normal,
      decoration: textDecoration,
      fontSize: FontSize.large,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Subtitle 2**.
  static TextStyle subtitle2({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
      fontSize: FontSize.medium,
    );
  }

  static TextStyle appBarHome({
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: SafeColors.textColors.dark,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
      fontSize: FontSize.large,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **BodyText 1**.
  static TextStyle bodyText1({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.normal,
      decoration: textDecoration,
      fontSize: FontSize.medium,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **BodyText 2**.
  static TextStyle bodyText2({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.normal,
      decoration: textDecoration,
      fontSize: FontSize.small,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **BodyText 3**.
  static TextStyle bodyText3({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.bold,
      decoration: textDecoration,
      fontSize: FontSize.small,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Caption**.
  static TextStyle caption({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.w300,
      decoration: textDecoration,
      fontSize: FontSize.xSmall,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Helper**.
  static TextStyle helper({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.w500,
      decoration: textDecoration,
      fontSize: FontSize.xxSmall,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Button**.
  static TextStyle button({
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: FontWeight.w500,
      fontSize: FontSize.small,
      decoration: textDecoration,
    );
  }

  ///Método que retorna estilização de texto correspondente ao **Label**.
  static TextStyle label({
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return GoogleFonts.poppins(
      color: color ?? SafeColors.textColors.dark,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: textDecoration,
      fontSize: FontSize.xSmall,
    );
  }
}
