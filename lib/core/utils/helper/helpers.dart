import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/theme_state.dart';
import 'package:provider/provider.dart';

///O [Helpers] é uma classe responsável por gerenciar e armazenar variádos
///tipos de métodos de validação.
class Helpers {
  ///Método responsável por retornar uma cor tendo como base o tema que o aplicativo se encontra.
  static Color getColorFromTheme({
    required BuildContext context,
    required Color darkModeColor,
    required Color lightModeColor,
  }) {
    if (Provider.of<ThemeState>(context).theme == ThemeType.DARK) {
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
    if (Provider.of<ThemeState>(context).theme == ThemeType.DARK) {
      return darkModeImagePath;
    }
    return lightModeImagePath;
  }
}
