import 'package:flutter/material.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const MyTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: kColorStatusActive,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyles.label(),
        hintText: widget.hintText,
        hintStyle: TextStyles.label(),
        suffixIcon: widget.suffixIcon,
      ),
      obscureText: widget.obscureText ?? false,
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
