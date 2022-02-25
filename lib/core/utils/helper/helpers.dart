import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/themes/theme_state.dart';
import 'package:provider/provider.dart';

///O [Helpers] é uma classe responsável por gerenciar e armazenar variádos
///tipos de métodos de validação.
class Helpers {
  ///Método responsável por realizar a validação de um nome.
  static bool validateName(String name) {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  ///Método responsável por realizar a validação de uma data.
  static bool validateDate(value) {
    if (value.length == 10) {
      int day = int.parse(
        value.substring(0, 2),
      );
      int month = int.parse(
        value.substring(3, 5),
      );
      int year = int.parse(
        value.substring(6, 10),
      );

      if (day < 1 || day > 31) return false;
      if (month < 1 || month > 12) return false;
      if (year < 1910 || year > 2003) return false;
    }

    return true;
  }

  ///Método responsável por realizar a validação de um e-mail.
  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern as String);
    return regex.hasMatch(value.trim());
  }

  ///Método responsável por realizar a validação de uma senha.
  static bool validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d][\w~@#$%^&*+=`|{}:;!.?\"()\[\]-]{7,}$';
    RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(value.trim());
  }

  ///Método responsável por capturar um link dentro de uma String.
  static String? getLinkFromText(String value) {
    String? finalValue;
    Pattern pattern =
        r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
    RegExp regex = RegExp(pattern as String);
    Iterable<RegExpMatch> matches = regex.allMatches(value);

    if (matches.isNotEmpty) {
      finalValue = value.substring(matches.first.start, matches.first.end);
    }

    return finalValue;
  }

  ///Método responsável por realizar a formatação de uma data vinda de uma API.
  static String formatterDateFromAPI(String date) {
    var split = date.split("-");
    return split[2] + '/' + split[1] + '/' + split[0];
  }

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
