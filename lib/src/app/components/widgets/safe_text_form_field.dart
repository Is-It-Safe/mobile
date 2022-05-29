import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_it_safe_app/src/app/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/app/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

class SafeTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? bottomText;
  final String labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FormFieldValidator<String>? validator;

  const SafeTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.onEditingComplete,
    this.bottomText,
    this.inputFormatters,
    this.readOnly,
  }) : super(key: key);

  @override
  _SafeTextFormFieldState createState() => _SafeTextFormFieldState();
}

class _SafeTextFormFieldState extends State<SafeTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          cursorColor: SafeColors.statusColors.active,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyles.label(
              color: _focusNode.hasFocus
                  ? SafeColors.statusColors.active
                  : SafeColors.textColors.dark,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyles.label(),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
        ),
        Visibility(
          visible: widget.bottomText?.isEmpty ?? false,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.bottomText ?? StringConstants.empty,
                style: TextStyles.helper(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
