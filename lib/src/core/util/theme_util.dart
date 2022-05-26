import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/components/theme/theme_state.dart';
import 'package:provider/provider.dart';

class ThemeUtil {
  ///Método responsável por retornar uma cor tendo como base o tema que o aplicativo se encontra.
  static Color getColorFromTheme({
    required BuildContext context,
    required Color darkModeColor,
    required Color lightModeColor,
  }) {
    if (Provider.of<ThemeState>(context).theme == ThemeType.dark) {
      return darkModeColor;
    }
    return lightModeColor;
  }

  ///Método responsável por retornar uma imagem tendo como base o tema que o aplicativo se encontra.
  static String getImageFromTheme({
    required BuildContext context,
    required String darkModeImagePath,
    required String lightModeImagePath,
  }) {
    if (Provider.of<ThemeState>(context).theme == ThemeType.dark) {
      return darkModeImagePath;
    }
    return lightModeImagePath;
  }
}
