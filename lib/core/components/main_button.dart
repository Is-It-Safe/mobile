import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/dark_theme_colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? color;

  const MainButton({
    Key? key,
    required this.text,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: primaryTextColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
          ),
        ),
      ),
    );
  }
}
