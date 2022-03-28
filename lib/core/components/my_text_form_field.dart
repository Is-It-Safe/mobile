import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_it_safe_app/core/utils/style/colors/general_colors.dart';
import 'package:is_it_safe_app/core/utils/style/themes/text_styles.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? bottomText;
  final String labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final int? minLines;
  final int? maxLines;

  const MyTextFormField({
    Key? key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.onEditingComplete,
    this.bottomText,
    this.inputFormatters,
    this.readOnly,
    this.minLines,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
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
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          controller: widget.controller,
          cursorColor: kColorStatusActive,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyles.label(
              color: _focusNode.hasFocus ? kColorStatusActive : kColorTextLight,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyles.label(),
            suffixIcon: widget.suffixIcon,
          ),
          obscureText: widget.obscureText ?? false,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
        ),
        Visibility(
          visible: widget.bottomText != null,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.bottomText ?? '',
                style: TextStyles.helper(fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }
}
