import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';

class SafeCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool? value) onChanged;
  const SafeCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: SafeColors.buttonColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: BorderSide(
        color: SafeColors.buttonColors.primary,
        width: 1,
      ),
      onChanged: onChanged,
    );
  }
}
