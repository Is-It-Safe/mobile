// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_it_safe_app/generated/l10n.dart';
import 'package:is_it_safe_app/src/components/style/colors/safe_colors.dart';
import 'package:is_it_safe_app/src/components/style/text/text_styles.dart';
import 'package:is_it_safe_app/src/core/constants/string_constants.dart';

enum DropdownType { none, loading, error }

class SafeTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? bottomText;
  final String? labelText;
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
  final DropdownType dropdownType;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final String? obscuringCharacter;
  final AutovalidateMode? autovalidateMode;

  const SafeTextFormField({
    Key? key,
    this.labelText,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.onEditingComplete,
    this.bottomText,
    this.inputFormatters,
    this.readOnly = false,
    this.dropdownType = DropdownType.none,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscuringCharacter,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  @override
  _SafeTextFormFieldState createState() => _SafeTextFormFieldState();
}

class _SafeTextFormFieldState extends State<SafeTextFormField> {
  late FocusNode _focusNode;
  late bool isReadOnly;
  late String labelText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
    isReadOnly = _getIsReadOnly();
    labelText = _getLabelText();
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
          focusNode: widget.focusNode,
          cursorColor: SafeColors.statusColors.active,
          readOnly: isReadOnly,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            counterText: StringConstants.empty,
            labelText: labelText,
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
          obscuringCharacter: widget.obscuringCharacter ?? '•',
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          autovalidateMode: widget.autovalidateMode,
        ),
        Visibility(
          visible: widget.bottomText?.isNotEmpty ?? false,
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

  bool _getIsReadOnly() {
    switch (widget.dropdownType) {
      case DropdownType.loading:
        return true;
      case DropdownType.error:
        return true;
      default:
        return widget.readOnly ?? false;
    }
  }

  String _getLabelText() {
    switch (widget.dropdownType) {
      case DropdownType.loading:
        return S.current.textLoading;
      case DropdownType.error:
        return S.current.textErrorDropdown;
      default:
        return widget.labelText ?? StringConstants.empty;
    }
  }
}
