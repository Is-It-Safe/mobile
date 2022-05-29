import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/app/components/style/colors/safe_colors.dart';

class SafeShowFieldButton extends StatefulWidget {
  final bool value;
  final Function() onTap;
  const SafeShowFieldButton({
    Key? key,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SafeShowFieldButton> createState() => _SafeShowFieldButtonState();
}

class _SafeShowFieldButtonState extends State<SafeShowFieldButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Icon(
        widget.value ? Icons.visibility : Icons.visibility_off,
        color: SafeColors.componentsColors.iconColors.main,
      ),
    );
  }
}
