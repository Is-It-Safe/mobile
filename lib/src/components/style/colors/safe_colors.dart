import 'package:flutter/material.dart';

class SafeColors {
  static _GeneralColors generalColors = _GeneralColors();
  static _ComponentsColors componentsColors = _ComponentsColors();
  static _StatusColors statusColors = _StatusColors();
  static _TextColors textColors = _TextColors();
  static _ButtonColors buttonColors = _ButtonColors();
  static _MaterialButtonColors materialButtonColors = _MaterialButtonColors();
}

class _GeneralColors {
  Color background = const Color(0xFFFAF9FF);
  Color backgroundSplash = const Color(0xFF5C45ED);
  Color primary = const Color(0xFFEFECFD);
  Color secondary = const Color(0xFF241B5E);
  Color highlight = const Color(0xFF6200EE);
  Color review = const Color(0xFF322580);
  Color white = const Color(0xFFFAF9FF);
}

class _ComponentsColors {
  Color smoothPageIndicatorColor = const Color(0xFFE9E9E9);
  _IconColors iconColors = _IconColors();
}

class _IconColors {
  Color main = const Color(0xFF190A33);
  Color navBar = const Color(0xFF7C68F0);
}

class _StatusColors {
  Color active = const Color(0xFF6200EE);
  Color error = const Color(0xFFEB3D3D);
  Color success = const Color(0xFF2ECC71);
  Color info = const Color(0xFFB6B2C2);
  Color info2 = const Color(0xFF535353);
  Color alert = const Color(0xFFffcc00);
}

class _TextColors {
  Color dark = const Color(0xFF190A33);
  Color white = const Color(0xFFFAF9FF);
  Color label = const Color(0xFF535353);
  Color disabled = const Color(0xFFB6B2C2);
}

class _ButtonColors {
  Color primary = const Color(0xFF5C45ED);
  Color secondary = const Color(0xFF7B61FF);
  Color disabled = const Color(0xFFDADADA);
  Color danger = const Color(0xFFEB3D3D);
}

class _MaterialButtonColors {
  MaterialColor primary = const MaterialColor(
    0xFF5C45ED,
    _materialColorButtonPrimaryMap,
  );
}

const Map<int, Color> _materialColorButtonPrimaryMap = {
  50: Color.fromRGBO(92, 69, 237, .1),
  100: Color.fromRGBO(92, 69, 237, .2),
  200: Color.fromRGBO(92, 69, 237, .3),
  300: Color.fromRGBO(92, 69, 237, .4),
  400: Color.fromRGBO(92, 69, 237, .5),
  500: Color.fromRGBO(92, 69, 237, .6),
  600: Color.fromRGBO(92, 69, 237, .7),
  700: Color.fromRGBO(92, 69, 237, .8),
  800: Color.fromRGBO(92, 69, 237, .9),
  900: Color.fromRGBO(92, 69, 237, 1),
};
