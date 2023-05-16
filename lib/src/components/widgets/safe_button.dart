import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';

enum ButtonSize { small, large }

enum ButtonState { rest, disabled, danger }

class SafeButton extends StatelessWidget {
  final String title;
  final bool? hasBackground;
  final bool? hasBorder;
  final Function()? onTap;
  final ButtonSize? size;
  final ButtonState? state;
  final TextStyle? style;
  const SafeButton({
    Key? key,
    required this.title,
    this.onTap,
    this.style,
    this.hasBackground = true,
    this.hasBorder = false,
    this.size = ButtonSize.large,
    this.state = ButtonState.rest,
  }) : super(key: key);

  final double _height = 56;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _mountButton(context),
    );
  }

  Widget _mountButton(BuildContext context) {
    final largeWidth = MediaQuery.of(context).size.width;
    final smallWidth = hasBackground == true
        ? MediaQuery.of(context).size.width * 0.45
        : MediaQuery.of(context).size.width * 0.35;

    return Container(
      height: _height,
      width: size == ButtonSize.large ? largeWidth : smallWidth,
      decoration: BoxDecoration(
        color: hasBackground == true ? _getColor() : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: hasBorder == true ? Border.all(color: _getColor()) : null,
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: style ??
              TextStyles.button(
                color: _getTextColor(),
              ),
        ),
      ),
    );
  }

  Color _getColor() {
    Color color;
    switch (state) {
      case ButtonState.danger:
        color = SafeColors.buttonColors.danger;
        break;
      case ButtonState.disabled:
        color = SafeColors.buttonColors.disabled;
        break;
      case ButtonState.rest:
        color = SafeColors.buttonColors.primary;
        break;
      default:
        color = SafeColors.buttonColors.primary;
    }
    return color;
  }

  Color _getTextColor() {
    Color color;
    switch (state) {
      case ButtonState.danger:
        color = hasBackground == true
            ? SafeColors.textColors.white
            : SafeColors.textColors.dark;

        break;
      case ButtonState.disabled:
        color = hasBackground == true
            ? SafeColors.textColors.dark
            : SafeColors.textColors.disabled;

        break;

      case ButtonState.rest:
        color = hasBackground == true
            ? SafeColors.textColors.white
            : SafeColors.textColors.dark;

        break;
      default:
        color = hasBackground == true
            ? SafeColors.textColors.white
            : SafeColors.textColors.dark;
    }
    return color;
  }
}
