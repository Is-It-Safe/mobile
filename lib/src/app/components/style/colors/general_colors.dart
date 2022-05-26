import 'package:flutter/material.dart';

import 'general_material_colors.dart';

class SafeColors {
  static GeneralColors generalColors = GeneralColors();
  static NavBarColors navBarColors = NavBarColors();
  static StatusColors statusColors = StatusColors();
  static TextColors textColors = TextColors();
  static ButtonColors buttonColors = ButtonColors();
}

class GeneralColors {
  Color background = const Color(0xFFFAF9FF);
  Color primary = const Color(0xFFEFECFD);
  Color secondary = const Color(0xFF241B5E);
  Color highlight = const Color(0xFF6200EE);
  Color review = const Color(0xFF322580);
  Color white = const Color(0xFFFAF9FF);
}

class NavBarColors {
  Color icon = const Color(0xFF7C68F0);
}

class StatusColors {
  Color active = const Color(0xFF6200EE);
  Color error = const Color(0xFFEB3D3D);
  Color success = const Color(0xFF2ECC71);
}

class TextColors {
  Color dark = const Color(0xFF190A33);
  Color label = const Color(0xFF535353);
}

class ButtonColors {
  Color primary = const Color(0xFF5C45ED);
  Color secondary = const Color(0xFF7B61FF);
  Color hover = const Color(0xFF4534B2);
  Color disabled = const Color(0xFFDADADA);
}

//TODO Remover constantes abaixo
@Deprecated('Use SafeColors.generalColors.background instead')
const Color kColorBackgroundLight = Color(0xFFFAF9FF);
@Deprecated('Use SafeColors.generalColors.primary instead')
const Color kColorPrimaryLight = Color(0xFFEFECFD);
@Deprecated('Use SafeColors.generalColors.secondary instead')
const Color kColorSecondaryLight = Color(0xFF241B5E);
@Deprecated('Use SafeColors.generalColors.navBarColors.icon instead')
const Color kColorNavBarIcon = Color(0xFF7C68F0);
@Deprecated('Use SafeColors.generalColors.highlight instead')
const Color kColorHighlight = Color(0xFF6200EE);
@Deprecated('Use SafeColors.generalColors.review instead')
const Color kColorReview = Color(0xFF322580);
@Deprecated('Use SafeColors.success instead')
const Color kColorReviewSuccess = Color(0xFF2ECC71);
@Deprecated('Use SafeColors.generalColors.white instead')
const Color kColorWhiteBackground = Color(0xFFFAF9FF);

@Deprecated('Use SafeColors.statusColors.active instead')
const Color kColorStatusActive = Color(0xFF6200EE);
@Deprecated('Use SafeColors.statusColors.error instead')
const Color kColorStatusError = Color(0xFFEB3D3D);
@Deprecated('Use SafeColors.statusColors.success instead')
const Color kColorStatusSuccess = Color(0xFF2ECC71);
@Deprecated('Use SafeColors.statusColors.disabled instead')
const Color kColorStatusDisabled = Color(0xFFDADADA);

@Deprecated('Use SafeColors.textColors.dark instead')
const Color kColorTextLight = Color(0xFF190A33);
@Deprecated('Use SafeColors.textColors.label instead')
const Color kColorTextLabel = Color(0xFF535353);

@Deprecated('Use SafeColors.buttonColors.primary instead')
const Color kColorButtonPrimary = Color(0xFF5C45ED);
@Deprecated('Use SafeColors.buttonColors.secondary instead')
const Color kColorButtonSecondary = Color(0xFF7B61FF);
@Deprecated('Use SafeColors.buttonColors.hover instead')
const Color kColorButtonHover = Color(0xFF4534B2);
@Deprecated('Use SafeColors.buttonColors.disabled instead')
const Color kColorButtonInactive = Color(0xFFDADADA);

const MaterialColor kMaterialColorButtonPrimary =
    MaterialColor(0xFF5C45ED, kMaterialColorButtonPrimaryMap);
